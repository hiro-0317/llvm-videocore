//===-- VideoCore4InstrInfo.cpp - VideoCore4 Instruction Information -----------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the VideoCore4 implementation of the TargetInstrInfo class.
//
//===----------------------------------------------------------------------===//

#include "VideoCore4InstrInfo.h"
#include "VideoCore4.h"
#include "VideoCore4Util.h"
#include "VideoCore4MachineFunctionInfo.h"
#include "VideoCore4TargetMachine.h"

#include "llvm/IR/Function.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/MC/TargetRegistry.h"
#define GET_INSTRINFO_CTOR_DTOR
#include "VideoCore4GenInstrInfo.inc"

using namespace llvm;

VideoCore4InstrInfo::VideoCore4InstrInfo(const VideoCore4Subtarget &STI)
  : VideoCore4GenInstrInfo(VideoCore4::ADJCALLSTACKDOWN, VideoCore4::ADJCALLSTACKUP),
    RI(),
    Subtarget(STI) {}

VideoCore4InstrInfo*
VideoCore4InstrInfo::create(VideoCore4Subtarget &STI) {
  return new llvm::VideoCore4InstrInfo(STI);
}

void
VideoCore4InstrInfo::copyPhysReg(MachineBasicBlock          &MBB,
				 MachineBasicBlock::iterator I,
				 const DebugLoc             &DL,
				 MCRegister                  DestReg,
				 MCRegister                  SrcReg,
				 bool                        KillSrc) const {
  if (VideoCore4::FR32RegClass.contains(DestReg, SrcReg)) {
    BuildMI(MBB, I, DL, get(VideoCore4::MOV_F), DestReg)
      .addReg(SrcReg, getKillRegState(KillSrc));
    return;
  } else if (VideoCore4::GR32RegClass.contains(DestReg, SrcReg)) {
    BuildMI(MBB, I, DL, get(VideoCore4::MOV_R), DestReg)
      .addReg(SrcReg, getKillRegState(KillSrc));
    return;
  }
  llvm_unreachable("Cannot emit physreg copy instruction");
}

void
VideoCore4InstrInfo::storeRegToStackSlot(MachineBasicBlock          &MBB,
					 MachineBasicBlock::iterator I,
					 Register                    SrcReg,
					 bool                        isKill,
					 int                         FI,
					 const TargetRegisterClass  *RC,
					 const TargetRegisterInfo   *TRI,
					 Register                    VReg) const {
  
  DebugLoc DL;
  if (I != MBB.end())
    DL = I->getDebugLoc();

  MachineFunction        &MF  = *MBB.getParent();
  const MachineFrameInfo &MFI = MF.getFrameInfo();
  MachineMemOperand      *MMO = MF.getMachineMemOperand(MachinePointerInfo::getFixedStack(MF,
											  FI),
							MachineMemOperand::MOStore,
							MFI.getObjectSize(FI),
							MFI.getObjectAlign(FI));

  BuildMI(MBB, I, DL, get(VideoCore4::MEM32_ST_LI))
    .addReg(SrcReg, getKillRegState(isKill))
    .addFrameIndex(FI)
    .addImm(0)
    .addMemOperand(MMO);
}

void
VideoCore4InstrInfo::loadRegFromStackSlot(MachineBasicBlock          &MBB,
					  MachineBasicBlock::iterator I,
					  Register                    DestReg,
					  int                         FI,
					  const TargetRegisterClass  *RC,
					  const TargetRegisterInfo   *TRI,
					  Register                    VReg) const {
  
  DebugLoc DL;
  if (I != MBB.end())
    DL = I->getDebugLoc();
  
  MachineFunction        &MF  = *MBB.getParent();
  const MachineFrameInfo &MFI = MF.getFrameInfo();
  MachineMemOperand      *MMO = MF.getMachineMemOperand(MachinePointerInfo::getFixedStack(MF,
											  FI),
							MachineMemOperand::MOStore,
							MFI.getObjectSize(FI),
							MFI.getObjectAlign(FI));

  BuildMI(MBB, I, DL, get(VideoCore4::MEM32_LD_LI), DestReg)
    .addFrameIndex(FI)
    .addImm(0)
    .addMemOperand(MMO);
}

void
VideoCore4InstrInfo::adjustStackPtr(int64_t                     amount,
				    MachineBasicBlock          &MBB,
				    MachineBasicBlock::iterator I) const {
  DebugLoc DL = I != MBB.end() ? I->getDebugLoc() : DebugLoc();

  if (amount < 0) {
    BuildMI(MBB, I, DL, get(VideoCore4::SUB_F_RI), VideoCore4::SP)
      .addReg(VideoCore4::SP)
      .addImm(-amount);
  } else if (amount > 0) {
    BuildMI(MBB, I, DL, get(VideoCore4::ADD32I_P), VideoCore4::SP)
      .addReg(VideoCore4::SP)
      .addImm(amount);
  } else {
    /* Do nothing if we're adjusting the stack by zero */
  }
}

bool
VideoCore4InstrInfo::analyzeBranch(MachineBasicBlock               &MBB,
				   MachineBasicBlock              *&TBB,
				   MachineBasicBlock              *&FBB,
				   SmallVectorImpl<MachineOperand> &Cond,
				   bool                             AllowModify) const {
  MachineBasicBlock::iterator I = MBB.getLastNonDebugInstr();
  if (I == MBB.end()) {
    return false;
  }

  if (!isUnpredicatedTerminator(*I)) {
    return false;
  }

  // Get the last instruction in the block.
  MachineInstr               *LastInst = &*I;
  MachineBasicBlock::iterator LastMBBI = I;
  unsigned                    LastOpc  = LastInst->getOpcode();

  // If there is only one terminator instruction, process it.
  if (I == MBB.begin() || !isUnpredicatedTerminator(*--I)) {
    if (vc4util::isUnconditionalJump(LastOpc)) {
      TBB = LastInst->getOperand(0).getMBB();
      return false;
    }
    if (vc4util::isCondTrueBranch(LastOpc)) {
      // Block ends with fall-through condbranch.
      vc4util::parseCondBranch(LastInst, TBB, Cond);
      return false;
    }
    return true; // Can't handle indirect branch.
  }

  // Get the instruction before it if it is a terminator.
  MachineInstr *SecondLastInst = &*I;
  unsigned      SecondLastOpc  = SecondLastInst->getOpcode();

  // If AllowModify is true and the block ends with two or more unconditional
  // branches, delete all but the first unconditional branch.
  if (AllowModify && vc4util::isUnconditionalJump(LastOpc)) {
    while (vc4util::isUnconditionalJump(SecondLastOpc)) {
      LastInst->eraseFromParent();
      LastInst = SecondLastInst;
      LastOpc  = LastInst->getOpcode();
      if (I == MBB.begin() || !isUnpredicatedTerminator(*--I)) {
        // Return now the only terminator is an unconditional branch.
        TBB = LastInst->getOperand(0).getMBB();
        return false;
      } else {
        SecondLastInst = &*I;
        SecondLastOpc  = SecondLastInst->getOpcode();
      }
    }
  }

  // If the block ends with a B and a Bcc, handle it.
  if (vc4util::isCondBranch(SecondLastOpc) && vc4util::isUnconditionalJump(LastOpc)) {
    for (int i=0; i<vc4util::branchKindNum; i++) {
      if (SecondLastOpc == vc4util::BranchTakenOpcode[i]) {
	// Transform the code
	//
	// L2:
	//    bt L1
	//    ba L2
	// L1:
	//    ..
	//
	// into
	//
	// L2:
	//   bf L2
	// L1: 
	//   ...
	//
	MachineBasicBlock *TargetBB = SecondLastInst->getOperand(2).getMBB();
	if (AllowModify
	    && LastMBBI != MBB.end()
	    && MBB.isLayoutSuccessor(TargetBB)) {
	  MachineBasicBlock *BNcondMBB = LastInst->getOperand(0).getMBB();

	  BuildMI(&MBB, MBB.findDebugLoc(SecondLastInst), get(vc4util::BranchNotTakenOpcode[i]))
	    .addReg(SecondLastInst->getOperand(0).getReg())
	    .addReg(SecondLastInst->getOperand(1).getReg())
	    .addMBB(BNcondMBB);

	  LastMBBI->eraseFromParent();

	  TBB = BNcondMBB;
	  FBB = TargetBB;
	  return false;
	}
      } else if (vc4util::isRawBranch(SecondLastOpc)) {
	// Transform the code
	//
	// L2:
	//    bt L1
	//    ba L2
	// L1:
	//    ..
	//
	// into
	//
	// L2:
	//   bf L2                            
	// L1: 
	//   ...
	//
	MachineBasicBlock *TargetBB = SecondLastInst->getOperand(0).getMBB();
	if (AllowModify
	    && LastMBBI != MBB.end()
	    && MBB.isLayoutSuccessor(TargetBB)) {
	  MachineBasicBlock::iterator OldInst   = SecondLastInst;
	  MachineBasicBlock          *BNcondMBB = LastInst->getOperand(0).getMBB();

	  BuildMI(&MBB, MBB.findDebugLoc(SecondLastInst), get(vc4util::reverseBranch(SecondLastOpc)))
	    .addMBB(BNcondMBB);

	  OldInst->eraseFromParent();
	  LastMBBI->eraseFromParent();

	  TBB = TargetBB;
	  FBB = BNcondMBB;
	  return false;
	}
      }
    }
    TBB = FBB = nullptr;
    return true;
  }

  // If the block ends with two unconditional branches, handle it.  The second 
  // one is not executed.
  if (vc4util::isUnconditionalJump(SecondLastOpc) && vc4util::isUnconditionalJump(LastOpc)) {
    TBB = SecondLastInst->getOperand(0).getMBB();
    return false;
  }

  // Otherwise, can't handle this.   
  return true;
}

unsigned
VideoCore4InstrInfo::insertBranch(MachineBasicBlock       &MBB,
				  MachineBasicBlock       *TBB,
				  MachineBasicBlock       *FBB,
				  ArrayRef<MachineOperand> Cond,
				  const DebugLoc          &DL,
				  int                     *BytesAdded) const {
  if (Cond.empty()) {
    BuildMI(&MBB, DL, get(VideoCore4::JMP32))
      .addMBB(TBB);
    return 1;
  }

  // FIXME(konda): handle this
  BuildMI(&MBB, DL, get(VideoCore4::JMP_TRUE_P))
    .addMBB(TBB);

  if (!FBB) {
    return 1;
  }

  BuildMI(&MBB, DL, get(VideoCore4::JMP32))
    .addMBB(FBB);

  return 2;
}

unsigned
VideoCore4InstrInfo::removeBranch(MachineBasicBlock &MBB,
				  int               *BytesRemoved) const {
  MachineBasicBlock::iterator I     = MBB.end();
  unsigned                    Count = 0;
  while (I != MBB.begin()) {
    --I;

    if (I->isDebugValue())
      continue;

    if (vc4util::isBranchMBBI(I) == false)
      break;

    I->eraseFromParent();
    I = MBB.end();
    ++Count;
  }

  return Count;
}

MachineBasicBlock*
VideoCore4InstrInfo::getBranchDestBlock(const MachineInstr &MI) const {
  switch (MI.getOpcode()) {
  default:
    {
      llvm_unreachable("cannot handle branch dst");
    }
  case VideoCore4::JMP_CC_EQ:
  case VideoCore4::JMP_CC_NE:
  case VideoCore4::JMP_CC_GT:
  case VideoCore4::JMP_CC_GE:
  case VideoCore4::JMP_CC_LT:
  case VideoCore4::JMP_CC_LE:
  case VideoCore4::JMP_CC_UGT:
  case VideoCore4::JMP_CC_UGE:
  case VideoCore4::JMP_CC_ULT:
  case VideoCore4::JMP_CC_ULE:
  case VideoCore4::JMP32:
    {
      return MI.getOperand(0).getMBB();
    }
  }
}


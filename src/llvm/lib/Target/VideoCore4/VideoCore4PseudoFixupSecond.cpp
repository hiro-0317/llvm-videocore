//===-- VideoCore4PseudoFixupSecond.cpp - VideoCore4 pseudo fixer ----===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// Expand FpMOVD/FpABSD/FpNEGD instructions into their single-precision pieces.
//
//===----------------------------------------------------------------------===//

#include "VideoCore4.h"
#include "VideoCore4Util.h"
#include "VideoCore4Subtarget.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/CodeGen/TargetInstrInfo.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Support/Debug.h"
#include "VideoCore4RegisterInfo.h"

#include <cstdlib>
#include <iostream>

#define DEBUG_TYPE "vc4-pseudo-fixup-second"
#define PASS_DESC  "VideoCore4 pseudo fixer second"

using namespace llvm;

namespace llvm {
  FunctionPass *createVideoCore4PseudoFixupSecondPass(void);
}

namespace {
  struct VideoCore4PseudoFixupSecond : public MachineFunctionPass {
    explicit VideoCore4PseudoFixupSecond() 
      : MachineFunctionPass(ID) {
      initializeVideoCore4PseudoFixupSecondPass(*PassRegistry::getPassRegistry());
    }

    StringRef getPassName() const override {
      return PASS_DESC;
    }

    bool runOnMachineBasicBlock(MachineBasicBlock &MBB);
    bool runOnMachineFunction(MachineFunction &F) override;

    static char ID;
  };
  char VideoCore4PseudoFixupSecond::ID = 0;
}

INITIALIZE_PASS(VideoCore4PseudoFixupSecond,
	        DEBUG_TYPE,
		PASS_DESC,
		false,
		false)

FunctionPass*
llvm::createVideoCore4PseudoFixupSecondPass() {
  return new VideoCore4PseudoFixupSecond();
}

bool
VideoCore4PseudoFixupSecond::runOnMachineBasicBlock(MachineBasicBlock &MBB) {
  bool Changed = false;

  const auto            &Subtarget = MBB.getParent()->getSubtarget();
  const TargetInstrInfo *TII       = Subtarget.getInstrInfo();

  for (MachineBasicBlock::iterator I = MBB.begin(); I != MBB.end();) {
    MachineInstr *MI = &(*I);
    I++;
    DebugLoc dl     = MI->getDebugLoc();
    unsigned Opcode = MI->getOpcode();

    auto OPT_ADD = [&MBB, MI, TII, I, dl, &Changed](void) {
      Register reg1 = MI->getOperand(0).getReg();
      Register reg2 = MI->getOperand(1).getReg();
      int32_t  imm  = MI->getOperand(2).getImm();

      if (isInt<16>(imm) && reg1 == reg2) {
	MBB.erase(MI);

	BuildMI(MBB, I, dl, TII->get(VideoCore4::ADD16I), reg1)
	  .addImm(imm);
	Changed = true;
      }
    };

    switch (Opcode) {
    case VideoCore4::ADD32I:
      {
	OPT_ADD();
	break;
      }
    default:
      {
	break;
      }
    }
  }

  // for debug 
  for (MachineBasicBlock::iterator I = MBB.begin(); I != MBB.end();) {
    MachineInstr *MI = &(*I);
    I++;
    DebugLoc dl     = MI->getDebugLoc();
    unsigned Opcode = MI->getOpcode();

    switch (Opcode) {
    default:
      {
	MI->dump();
	break;
      }
    }
  }

  return Changed;
}

bool
VideoCore4PseudoFixupSecond::runOnMachineFunction(MachineFunction &F) {
  if (skipFunction(F.getFunction())) {
    return false;
  }

  LLVM_DEBUG(dbgs() << "== VideoCore4PseudoFixupSecond == ("
             << F.getName()
             << ")\n");

  bool Changed = false;

  for (MachineFunction::iterator FI = F.begin(), FE = F.end();
       FI != FE; ++FI) {
    Changed |= runOnMachineBasicBlock(*FI);
  }

  return Changed;
}
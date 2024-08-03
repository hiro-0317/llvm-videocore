//===-- VideoCore4PseudoFixup.cpp - VideoCore4 pseudo fixer ----===//
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

#define DEBUG_TYPE "vc4-pseudo-fixup"
#define PASS_DESC  "VideoCore4 pseudo fixer"

using namespace llvm;

namespace llvm {
  FunctionPass *createVideoCore4PseudoFixupPass(void);
}

namespace {
  struct VideoCore4PseudoFixup : public MachineFunctionPass {
    explicit VideoCore4PseudoFixup() 
      : MachineFunctionPass(ID) {
      initializeVideoCore4PseudoFixupPass(*PassRegistry::getPassRegistry());
    }

    StringRef getPassName() const override {
      return PASS_DESC;
    }

    bool runOnMachineBasicBlock(MachineBasicBlock &MBB);
    bool runOnMachineFunction(MachineFunction &F) override;

    static char ID;
  };
  char VideoCore4PseudoFixup::ID = 0;
}

INITIALIZE_PASS(VideoCore4PseudoFixup,
	        DEBUG_TYPE,
		PASS_DESC,
		false,
		false)

FunctionPass*
llvm::createVideoCore4PseudoFixupPass() {
  return new VideoCore4PseudoFixup();
}

bool
VideoCore4PseudoFixup::runOnMachineBasicBlock(MachineBasicBlock &MBB) {
  bool Changed = false;

  const auto            &Subtarget = MBB.getParent()->getSubtarget();
  const TargetInstrInfo *TII       = Subtarget.getInstrInfo();

  for (MachineBasicBlock::iterator I = MBB.begin(); I != MBB.end();) {
    MachineInstr *MI = &(*I);
    I++;
    DebugLoc dl     = MI->getDebugLoc();
    unsigned Opcode = MI->getOpcode();

    auto JUMP_COMP_CC = [&MBB, MI, TII, I, dl, &Changed](unsigned opc) {
      Register           reg1 = MI->getOperand(0).getReg();
      Register           reg2 = MI->getOperand(1).getReg();
      MachineBasicBlock *BB   = MI->getOperand(2).getMBB();

      MBB.erase(MI);

      BuildMI(MBB, I, dl, TII->get(VideoCore4::CMP_F))
	.addReg(reg1)
	.addReg(reg2);
      BuildMI(MBB, I, dl, TII->get(opc))
	.addMBB(BB);

      Changed = true;
    };

    auto BITCONV = [&MBB, MI, TII, I, dl, &Changed]() {
      Register reg1 = MI->getOperand(0).getReg();
      Register reg2 = MI->getOperand(1).getReg();

      MBB.erase(MI);

      if (reg1 == reg2) {
	// do nothing (optimize)
      } else {
	BuildMI(MBB, I, dl, TII->get(VideoCore4::MOV_R), reg1)
	  .addReg(reg2);
      }

      Changed = true;
    };

    auto JUMP_FCOMP_CC = [&MBB, MI, TII, I, dl, &Changed](unsigned opc) {
        Register           reg1 = MI->getOperand(0).getReg();
        Register           reg2 = MI->getOperand(1).getReg();
        MachineBasicBlock *BB   = MI->getOperand(2).getMBB();

	MBB.erase(MI);

	BuildMI(MBB, I, dl, TII->get(VideoCore4::CMP_F))
	  .addReg(reg1)
	  .addReg(reg2);
	BuildMI(MBB, I, dl, TII->get(opc))
	  .addMBB(BB);

        Changed = true;
    };

    auto SELECT_CC = [&MBB, MI, TII, I, dl, &Changed](unsigned opc) {
      Register reg1 = MI->getOperand(0).getReg();
      Register reg2 = MI->getOperand(1).getReg();
      Register reg3 = MI->getOperand(2).getReg();
      Register reg4 = MI->getOperand(3).getReg();
      Register reg5 = MI->getOperand(4).getReg();

      MBB.erase(MI);

      if (reg1 == reg3) {
	BuildMI(MBB, I, dl, TII->get(VideoCore4::CMP_F))
	  .addReg(reg4)
	  .addReg(reg5);
	BuildMI(MBB, I, dl, TII->get(opc), reg1)
	  .addReg(reg2);
      } else if (reg1 == reg2) {
	BuildMI(MBB, I, dl, TII->get(VideoCore4::CMP_F))
	  .addReg(reg4)
	  .addReg(reg5);
	BuildMI(MBB, I, dl, TII->get(vc4util::reverseCmovConditon(opc)), reg1)
	  .addReg(reg3);
      } else {
	BuildMI(MBB, I, dl, TII->get(VideoCore4::CMP_F))
	  .addReg(reg4)
	  .addReg(reg5);
	BuildMI(MBB, I, dl, TII->get(opc), reg1)
	  .addReg(reg2);
	BuildMI(MBB, I, dl, TII->get(vc4util::reverseCmovConditon(opc)), reg1)
	  .addReg(reg3);
      }
 
      Changed = true;
    };

    auto F_SELECT_CC = [&MBB, MI, TII, I, dl, &Changed](unsigned opc) {
      Register reg1 = MI->getOperand(0).getReg();
      Register reg2 = MI->getOperand(1).getReg();
      Register reg3 = MI->getOperand(2).getReg();
      Register reg4 = MI->getOperand(3).getReg();
      Register reg5 = MI->getOperand(4).getReg();

      MBB.erase(MI);

      if (reg1 == reg3) {
	BuildMI(MBB, I, dl, TII->get(VideoCore4::CMP_F))
	  .addReg(reg4)
	  .addReg(reg5);
	BuildMI(MBB, I, dl, TII->get(opc), reg1)
	  .addReg(reg2);
      } else if (reg1 == reg2) {
	BuildMI(MBB, I, dl, TII->get(VideoCore4::CMP_F))
	  .addReg(reg4)
	  .addReg(reg5);
	BuildMI(MBB, I, dl, TII->get(vc4util::reverseCmovConditon(opc)), reg1)
	  .addReg(reg3);
      } else {
	BuildMI(MBB, I, dl, TII->get(VideoCore4::CMP_F))
	  .addReg(reg4)
	  .addReg(reg5);
	BuildMI(MBB, I, dl, TII->get(opc), reg1)
	  .addReg(reg2);
	BuildMI(MBB, I, dl, TII->get(vc4util::reverseCmovConditon(opc)), reg1)
	  .addReg(reg3);
      }

      Changed = true;
    };

    auto SETCC_RI = [&MBB, MI, TII, I, dl, &Changed](unsigned opc) {
      Register reg1 = MI->getOperand(0).getReg();
      Register reg2 = MI->getOperand(1).getReg();
      int32_t  imm  = MI->getOperand(2).getImm();

      MBB.erase(MI);

      BuildMI(MBB, I, dl, TII->get(VideoCore4::CMP_LI))
	.addReg(reg2)
	.addImm(imm);
      BuildMI(MBB, I, dl, TII->get(VideoCore4::MOV_FI), reg1)
	.addImm(0);
      BuildMI(MBB, I, dl, TII->get(opc), reg1)
	.addImm(1);

      Changed = true;
    };

    auto SETCC_RR = [&MBB, MI, TII, I, dl, &Changed](unsigned opc) {
      Register reg1 = MI->getOperand(0).getReg();
      Register reg2 = MI->getOperand(1).getReg();
      Register reg3 = MI->getOperand(2).getReg();

      MBB.erase(MI);

      BuildMI(MBB, I, dl, TII->get(VideoCore4::CMP_F))
	.addReg(reg2)
	.addReg(reg3);
      BuildMI(MBB, I, dl, TII->get(VideoCore4::MOV_FI), reg1)
	.addImm(0);
      BuildMI(MBB, I, dl, TII->get(opc), reg1)
	.addImm(1);

      Changed = true;
    };

    auto F_SETCC_RR = [&MBB, MI, TII, I, dl, &Changed](unsigned opc) {
      Register reg1 = MI->getOperand(0).getReg();
      Register reg2 = MI->getOperand(1).getReg();
      Register reg3 = MI->getOperand(2).getReg();

      MBB.erase(MI);

      BuildMI(MBB, I, dl, TII->get(VideoCore4::CMP_F))
	.addReg(reg2)
	.addReg(reg3);
      BuildMI(MBB, I, dl, TII->get(VideoCore4::MOV_FI), reg1)
	.addImm(0);
      BuildMI(MBB, I, dl, TII->get(opc), reg1)
	.addImm(1);

      Changed = true;
    };

    switch (Opcode) {
    case VideoCore4::JMP_COMP_EQ_P:
      {
	JUMP_COMP_CC(VideoCore4::JMP_CC_EQ);
	break;
      }
    case VideoCore4::JMP_COMP_NE_P:
      {
	JUMP_COMP_CC(VideoCore4::JMP_CC_NE);
	break;
      }
    case VideoCore4::JMP_COMP_GT_P:
      {
	JUMP_COMP_CC(VideoCore4::JMP_CC_GT);
	break;
      }
    case VideoCore4::JMP_COMP_GE_P:
      {
	JUMP_COMP_CC(VideoCore4::JMP_CC_GE);
	break;
      }
    case VideoCore4::JMP_COMP_LT_P:
      {
	JUMP_COMP_CC(VideoCore4::JMP_CC_LT);
	break;
      }
    case VideoCore4::JMP_COMP_LE_P:
      {
	JUMP_COMP_CC(VideoCore4::JMP_CC_LE);
	break;
      }
    case VideoCore4::JMP_COMP_UGT_P:
      {
	JUMP_COMP_CC(VideoCore4::JMP_CC_UGT);
	break;
      }
    case VideoCore4::JMP_COMP_UGE_P:
      {
	JUMP_COMP_CC(VideoCore4::JMP_CC_UGE);
	break;
      }
    case VideoCore4::JMP_COMP_ULT_P:
      {
	JUMP_COMP_CC(VideoCore4::JMP_CC_ULT);
	break;
      }
    case VideoCore4::JMP_COMP_ULE_P:
      {
	JUMP_COMP_CC(VideoCore4::JMP_CC_ULE);
	break;
      }
    case VideoCore4::JMP_COMP_EQ_F_P:
      {
	JUMP_COMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_EQ));
	break;
      }
    case VideoCore4::JMP_COMP_NE_F_P:
      {
	JUMP_COMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_NE));
	break;
      }
    case VideoCore4::JMP_COMP_GT_F_P:
      {
	JUMP_COMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_GT));
	break;
      }
    case VideoCore4::JMP_COMP_GE_F_P:
      {
	JUMP_COMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_GE));
	break;
      }
    case VideoCore4::JMP_COMP_LT_F_P:
      {
	JUMP_COMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_LT));
	break;
      }
    case VideoCore4::JMP_COMP_LE_F_P:
      {
	JUMP_COMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_LE));
	break;
      }
    case VideoCore4::JMP_COMP_UGT_F_P:
      {
	JUMP_COMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_UGT));
	break;
      }
    case VideoCore4::JMP_COMP_UGE_F_P:
      {
	JUMP_COMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_UGE));
	break;
      }
    case VideoCore4::JMP_COMP_ULT_F_P:
      {
	JUMP_COMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_ULT));
	break;
      }
    case VideoCore4::JMP_COMP_ULE_F_P:
      {
	JUMP_COMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_ULE));
	break;
      }
    case VideoCore4::SELECT_EQ_P:
      {
	SELECT_CC(VideoCore4::CMOV_EQ_RR);
	break;
      }
    case VideoCore4::SELECT_NE_P:
      {
	SELECT_CC(VideoCore4::CMOV_NE_RR);
	break;
      }
    case VideoCore4::SELECT_GT_P:
      {
	SELECT_CC(VideoCore4::CMOV_GT_RR);
	break;
      }
    case VideoCore4::SELECT_GE_P:
      {
	SELECT_CC(VideoCore4::CMOV_GE_RR);
	break;
      }
    case VideoCore4::SELECT_LT_P:
      {
	SELECT_CC(VideoCore4::CMOV_LT_RR);
	break;
      }
    case VideoCore4::SELECT_LE_P:
      {
	SELECT_CC(VideoCore4::CMOV_LE_RR);
	break;
      }
    case VideoCore4::SELECT_UGT_P:
      {
	SELECT_CC(VideoCore4::CMOV_UGT_RR);
	break;
      }
    case VideoCore4::SELECT_UGE_P:
      {
	SELECT_CC(VideoCore4::CMOV_UGE_RR);
	break;
      }
    case VideoCore4::SELECT_ULE_P:
      {
	SELECT_CC(VideoCore4::CMOV_ULE_RR);
	break;
      }
    case VideoCore4::SELECT_ULT_P:
      {
	SELECT_CC(VideoCore4::CMOV_ULT_RR);
	break;
      }
    case VideoCore4::FSELECT_EQ_P:
      {
	SELECT_CC(VideoCore4::CMOV_EQ_RR);
	break;
      }
    case VideoCore4::FSELECT_NE_P:
      {
	SELECT_CC(VideoCore4::CMOV_NE_RR);
	break;
      }
    case VideoCore4::FSELECT_GT_P:
      {
	SELECT_CC(VideoCore4::CMOV_GT_RR);
	break;
      }
    case VideoCore4::FSELECT_GE_P:
      {
	SELECT_CC(VideoCore4::CMOV_GE_RR);
	break;
      }
    case VideoCore4::FSELECT_LT_P:
      {
	SELECT_CC(VideoCore4::CMOV_LT_RR);
	break;
      }
    case VideoCore4::FSELECT_LE_P:
      {
	SELECT_CC(VideoCore4::CMOV_LE_RR);
	break;
      }
    case VideoCore4::FSELECT_UGT_P:
      {
	SELECT_CC(VideoCore4::CMOV_UGT_RR);
	break;
      }
    case VideoCore4::FSELECT_UGE_P:
      {
	SELECT_CC(VideoCore4::CMOV_UGE_RR);
	break;
      }
    case VideoCore4::FSELECT_ULT_P:
      {
	SELECT_CC(VideoCore4::CMOV_ULT_RR);
	break;
      }
    case VideoCore4::FSELECT_ULE_P:
      {
	SELECT_CC(VideoCore4::CMOV_ULE_RR);
	break;
      }
    case VideoCore4::SETCC_EQ_RI_P:
      {
	SETCC_RI(VideoCore4::CMOV_EQ_RI);
	break;
      }
    case VideoCore4::SETCC_NE_RI_P:
      {
	SETCC_RI(VideoCore4::CMOV_NE_RI);
	break;
      }
    case VideoCore4::SETCC_GT_RI_P:
      {
	SETCC_RI(VideoCore4::CMOV_GT_RI);
	break;
      }
    case VideoCore4::SETCC_GE_RI_P:
      {
	SETCC_RI(VideoCore4::CMOV_GE_RI);
	break;
      }
    case VideoCore4::SETCC_LT_RI_P:
      {
	SETCC_RI(VideoCore4::CMOV_LT_RI);
	break;
      }
    case VideoCore4::SETCC_LE_RI_P:
      {
	SETCC_RI(VideoCore4::CMOV_LE_RI);
	break;
      }
    case VideoCore4::SETCC_UGT_RI_P:
      {
	SETCC_RI(VideoCore4::CMOV_UGT_RI);
	break;
      }
    case VideoCore4::SETCC_UGE_RI_P:
      {
	SETCC_RI(VideoCore4::CMOV_UGE_RI);
	break;
      }
    case VideoCore4::SETCC_ULT_RI_P:
      {
	SETCC_RI(VideoCore4::CMOV_ULT_RI);
	break;
      }
    case VideoCore4::SETCC_ULE_RI_P:
      {
	SETCC_RI(VideoCore4::CMOV_ULE_RI);
	break;
      }
    case VideoCore4::SETCC_EQ_RR_P:
      {
	SETCC_RR(VideoCore4::CMOV_EQ_RR);
	break;
      }
    case VideoCore4::SETCC_NE_RR_P:
      {
	SETCC_RR(VideoCore4::CMOV_NE_RR);
	break;
      }
    case VideoCore4::SETCC_GT_RR_P:
      {
	SETCC_RR(VideoCore4::CMOV_GT_RR);
	break;
      }
    case VideoCore4::SETCC_GE_RR_P:
      {
	SETCC_RR(VideoCore4::CMOV_GE_RR);
	break;
      }
    case VideoCore4::SETCC_LT_RR_P:
      {
	SETCC_RR(VideoCore4::CMOV_LT_RR);
	break;
      }
    case VideoCore4::SETCC_LE_RR_P:
      {
	SETCC_RR(VideoCore4::CMOV_LE_RR);
	break;
      }
    case VideoCore4::SETCC_UGT_RR_P:
      {
	SETCC_RR(VideoCore4::CMOV_UGT_RR);
	break;
      }
    case VideoCore4::SETCC_UGE_RR_P:
      {
	SETCC_RR(VideoCore4::CMOV_UGE_RR);
	break;
      }
    case VideoCore4::SETCC_ULT_RR_P:
      {
	SETCC_RR(VideoCore4::CMOV_ULT_RR);
	break;
      }
    case VideoCore4::SETCC_ULE_RR_P:
      {
	SETCC_RR(VideoCore4::CMOV_ULE_RR);
	break;
      }
    case VideoCore4::JMP_FCOMP_OEQ_P:
      {
	JUMP_FCOMP_CC(VideoCore4::JMP_CC_EQ);
	break;
      }
    case VideoCore4::JMP_FCOMP_ONE_P:
      {
	JUMP_FCOMP_CC(VideoCore4::JMP_CC_NE);
	break;
      }
    case VideoCore4::JMP_FCOMP_OGT_P:
      {
	JUMP_FCOMP_CC(VideoCore4::JMP_CC_GT);
	break;
      }
    case VideoCore4::JMP_FCOMP_OGE_P:
      {
	JUMP_FCOMP_CC(VideoCore4::JMP_CC_GE);
	break;
      }
    case VideoCore4::JMP_FCOMP_OLT_P:
      {
	JUMP_FCOMP_CC(VideoCore4::JMP_CC_LT);
	break;
      }
    case VideoCore4::JMP_FCOMP_OLE_P:
      {
	JUMP_FCOMP_CC(VideoCore4::JMP_CC_LE);
	break;
      }
    case VideoCore4::JMP_FCOMP_UEQ_P:
      {
	JUMP_FCOMP_CC(VideoCore4::JMP_CC_EQ);
	break;
      }
    case VideoCore4::JMP_FCOMP_UNE_P:
      {
	JUMP_FCOMP_CC(VideoCore4::JMP_CC_NE);
	break;
      }
    case VideoCore4::JMP_FCOMP_UGT_P:
      {
	JUMP_FCOMP_CC(VideoCore4::JMP_CC_UGT);
	break;
      }
    case VideoCore4::JMP_FCOMP_UGE_P:
      {
	JUMP_FCOMP_CC(VideoCore4::JMP_CC_UGE);
	break;
      }
    case VideoCore4::JMP_FCOMP_ULT_P:
      {
	JUMP_FCOMP_CC(VideoCore4::JMP_CC_ULT);
	break;
      }
    case VideoCore4::JMP_FCOMP_ULE_P:
      {
	JUMP_FCOMP_CC(VideoCore4::JMP_CC_ULE);
	break;
      }
    case VideoCore4::JMP_FCOMP_OEQ_F_P:
      {
	JUMP_FCOMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_EQ));
	break;
      }
    case VideoCore4::JMP_FCOMP_ONE_F_P:
      {
	JUMP_FCOMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_NE));
	break;
      }
    case VideoCore4::JMP_FCOMP_OGT_F_P:
      {
	JUMP_FCOMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_GT));
	break;
      }
    case VideoCore4::JMP_FCOMP_OGE_F_P:
      {
	JUMP_FCOMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_GE));
	break;
      }
    case VideoCore4::JMP_FCOMP_OLT_F_P:
      {
	JUMP_FCOMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_LT));
	break;
      }
    case VideoCore4::JMP_FCOMP_OLE_F_P:
      {
	JUMP_FCOMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_LE));
	break;
      }
    case VideoCore4::JMP_FCOMP_UEQ_F_P:
      {
	JUMP_FCOMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_EQ));
	break;
      }
    case VideoCore4::JMP_FCOMP_UNE_F_P:
      {
	JUMP_FCOMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_NE));
	break;
      }
    case VideoCore4::JMP_FCOMP_UGT_F_P:
      {
	JUMP_FCOMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_UGT));
	break;
      }
    case VideoCore4::JMP_FCOMP_UGE_F_P:
      {
	JUMP_FCOMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_UGE));
	break;
      }
    case VideoCore4::JMP_FCOMP_ULT_F_P:
      {
	JUMP_FCOMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_ULT));
	break;
      }
    case VideoCore4::JMP_FCOMP_ULE_F_P:
      {
	JUMP_FCOMP_CC(vc4util::reverseBranch(VideoCore4::JMP_CC_ULE));
	break;
      }
    case VideoCore4::F_SELECT_OEQ_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_EQ_RR);
	break;
      }
    case VideoCore4::F_SELECT_ONE_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_NE_RR);
	break;
      }
    case VideoCore4::F_SELECT_OGT_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_GT_RR);
	break;
      }
    case VideoCore4::F_SELECT_OGE_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_GE_RR);
	break;
      }
    case VideoCore4::F_SELECT_OLT_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_LT_RR);
	break;
      }
    case VideoCore4::F_SELECT_OLE_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_LE_RR);
	break;
      }
    case VideoCore4::F_SELECT_UEQ_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_EQ_RR);
	break;
      }
    case VideoCore4::F_SELECT_UNE_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_NE_RR);
	break;
      }
    case VideoCore4::F_SELECT_UGT_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_GT_RR);
	break;
      }
    case VideoCore4::F_SELECT_UGE_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_GE_RR);
	break;
      }
    case VideoCore4::F_SELECT_ULT_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_LT_RR);
	break;
      }
    case VideoCore4::F_SELECT_ULE_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_LE_RR);
	break;
      }
    case VideoCore4::F_FSELECT_OEQ_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_EQ_RR);
	break;
      }
    case VideoCore4::F_FSELECT_ONE_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_NE_RR);
	break;
      }
    case VideoCore4::F_FSELECT_OGT_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_GT_RR);
	break;
      }
    case VideoCore4::F_FSELECT_OGE_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_GE_RR);
	break;
      }
    case VideoCore4::F_FSELECT_OLT_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_LT_RR);
	break;
      }
    case VideoCore4::F_FSELECT_OLE_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_LE_RR);
	break;
      }
    case VideoCore4::F_FSELECT_UEQ_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_EQ_RR);
	break;
      }
    case VideoCore4::F_FSELECT_UNE_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_NE_RR);
	break;
      }
    case VideoCore4::F_FSELECT_UGT_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_GT_RR);
	break;
      }
    case VideoCore4::F_FSELECT_UGE_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_GE_RR);
	break;
      }
    case VideoCore4::F_FSELECT_ULT_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_LT_RR);
	break;
      }
    case VideoCore4::F_FSELECT_ULE_P:
      {
	F_SELECT_CC(VideoCore4::CMOV_LE_RR);
	break;
      }
    case VideoCore4::F_SETCC_OEQ_RR_P:
      {
	F_SETCC_RR(VideoCore4::CMOV_EQ_RR);
	break;
      }
    case VideoCore4::F_SETCC_ONE_RR_P:
      {
	F_SETCC_RR(VideoCore4::CMOV_NE_RR);
	break;
      }
    case VideoCore4::F_SETCC_OGT_RR_P:
      {
	F_SETCC_RR(VideoCore4::CMOV_GT_RR);
	break;
      }
    case VideoCore4::F_SETCC_OGE_RR_P:
      {
	F_SETCC_RR(VideoCore4::CMOV_GE_RR);
	break;
      }
    case VideoCore4::F_SETCC_OLT_RR_P:
      {
	F_SETCC_RR(VideoCore4::CMOV_LT_RR);
	break;
      }
    case VideoCore4::F_SETCC_OLE_RR_P:
      {
	F_SETCC_RR(VideoCore4::CMOV_LE_RR);
	break;
      }
    case VideoCore4::F_SETCC_UEQ_RR_P:
      {
	F_SETCC_RR(VideoCore4::CMOV_EQ_RR);
	break;
      }
    case VideoCore4::F_SETCC_UNE_RR_P:
      {
	F_SETCC_RR(VideoCore4::CMOV_NE_RR);
	break;
      }
    case VideoCore4::F_SETCC_UGT_RR_P:
      {
	F_SETCC_RR(VideoCore4::CMOV_GT_RR);
	break;
      }
    case VideoCore4::F_SETCC_UGE_RR_P:
      {
	F_SETCC_RR(VideoCore4::CMOV_GE_RR);
	break;
      }
    case VideoCore4::F_SETCC_ULT_RR_P:
      {
	F_SETCC_RR(VideoCore4::CMOV_LT_RR);
	break;
      }
    case VideoCore4::F_SETCC_ULE_RR_P:
      {
	F_SETCC_RR(VideoCore4::CMOV_LE_RR);
	break;
      }
    case VideoCore4::ITOFCONV_P:
      {
	BITCONV();
	break;
      }
    case VideoCore4::FTOICONV_P:
      {
	BITCONV();
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
VideoCore4PseudoFixup::runOnMachineFunction(MachineFunction &F) {
  if (skipFunction(F.getFunction())) {
    return false;
  }

  LLVM_DEBUG(dbgs() << "== VideoCore4PseudoFixup == ("
             << F.getName()
             << ")\n");

  bool Changed = false;

  for (MachineFunction::iterator FI = F.begin(), FE = F.end();
       FI != FE; ++FI) {
    Changed |= runOnMachineBasicBlock(*FI);
  }

  return Changed;
}

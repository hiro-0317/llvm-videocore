#ifndef __HEADER_VIDEOCORE4_UTIL__
#define __HEADER_VIDEOCORE4_UTIL__

#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineMemOperand.h"
#include "llvm/CodeGen/TargetRegisterInfo.h"
#include "llvm/Pass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"

#include <iostream>

namespace vc4util {
  const int branchKindNum = 22;
  const int numDelayslot  = 3;

  static inline bool
  isLiveOutReg(llvm::MachineBasicBlock* MBB,
               llvm::Register           Reg) {
    for (llvm::MachineBasicBlock::succ_iterator SI = MBB->succ_begin(), SIE = MBB->succ_end(); SI != SIE; SI++) {
      for (llvm::MachineBasicBlock::livein_iterator LI = (*SI)->livein_begin(); LI != (*SI)->livein_end(); LI++) {
	llvm::Register LiveOut = (llvm::Register)LI->PhysReg;

        if (Reg == LiveOut) {
          return true;
        }
      }
    }
    return false;
  }

  // ToDo
  static inline
  bool isSchedulingBoundary(unsigned opc) {
    switch (opc) {
    case llvm::VideoCore4::RET:
    case llvm::VideoCore4::CALL:
    case llvm::VideoCore4::CALL_R:
    case llvm::VideoCore4::JMP32:
    case llvm::VideoCore4::JMPLINK32:
    case llvm::VideoCore4::BR_JT: // ToDo: erase this
    case llvm::VideoCore4::BR_IND_G:
    case llvm::VideoCore4::BR_LINK_G:
    case llvm::VideoCore4::JMP_CC_EQ:
    case llvm::VideoCore4::JMP_CC_NE:
    case llvm::VideoCore4::JMP_CC_GT:
    case llvm::VideoCore4::JMP_CC_GE:
    case llvm::VideoCore4::JMP_CC_LT:
    case llvm::VideoCore4::JMP_CC_LE:
    case llvm::VideoCore4::JMP_CC_UGT:
    case llvm::VideoCore4::JMP_CC_UGE:
    case llvm::VideoCore4::JMP_CC_ULT:
    case llvm::VideoCore4::JMP_CC_ULE:
    case llvm::VideoCore4::JMP_TRUE_P:
    case llvm::VideoCore4::JMP_COMP_EQ_P:
    case llvm::VideoCore4::JMP_COMP_NE_P:
    case llvm::VideoCore4::JMP_COMP_GT_P:
    case llvm::VideoCore4::JMP_COMP_GE_P:
    case llvm::VideoCore4::JMP_COMP_LT_P:
    case llvm::VideoCore4::JMP_COMP_LE_P:
    case llvm::VideoCore4::JMP_COMP_UGT_P:
    case llvm::VideoCore4::JMP_COMP_UGE_P:
    case llvm::VideoCore4::JMP_COMP_ULT_P:
    case llvm::VideoCore4::JMP_COMP_ULE_P:
    case llvm::VideoCore4::JMP_COMP_EQ_F_P:
    case llvm::VideoCore4::JMP_COMP_NE_F_P:
    case llvm::VideoCore4::JMP_COMP_GT_F_P:
    case llvm::VideoCore4::JMP_COMP_GE_F_P:
    case llvm::VideoCore4::JMP_COMP_LT_F_P:
    case llvm::VideoCore4::JMP_COMP_LE_F_P:
    case llvm::VideoCore4::JMP_COMP_UGT_F_P:
    case llvm::VideoCore4::JMP_COMP_UGE_F_P:
    case llvm::VideoCore4::JMP_COMP_ULT_F_P:
    case llvm::VideoCore4::JMP_COMP_ULE_F_P:
      {
	return true;
      }
    default:
      {
	return false;
      }
    }
    return false;
  }

  inline std::string
  getRegisterName(llvm::Register reg) {
    switch (reg) {
    case llvm::VideoCore4::R0:
      return "r0";
    case llvm::VideoCore4::R1:
      return "r1";
    case llvm::VideoCore4::R2:
      return "r2";
    case llvm::VideoCore4::R3:
      return "r3";
    case llvm::VideoCore4::R4:
      return "r4";
    case llvm::VideoCore4::R5:
      return "r5";
    case llvm::VideoCore4::R6:
      return "r6";
    case llvm::VideoCore4::R7:
      return "r7";
    case llvm::VideoCore4::R8:
      return "r8";
    case llvm::VideoCore4::R9:
      return "r9";
    case llvm::VideoCore4::R10:
      return "r10";
    case llvm::VideoCore4::R11:
      return "r11";
    case llvm::VideoCore4::R12:
      return "r12";
    case llvm::VideoCore4::R13:
      return "r13";
    case llvm::VideoCore4::R14:
      return "r14";
    case llvm::VideoCore4::R15:
      return "r15";
    case llvm::VideoCore4::R16:
      return "r16";
    case llvm::VideoCore4::R17:
      return "r17";
    case llvm::VideoCore4::R18:
      return "r18";
    case llvm::VideoCore4::R19:
      return "r19";
    case llvm::VideoCore4::R20:
      return "r20";
    case llvm::VideoCore4::R21:
      return "r21";
    case llvm::VideoCore4::R22:
      return "r22";
    case llvm::VideoCore4::R23:
    case llvm::VideoCore4::TMP:
      return "tmp";
    case llvm::VideoCore4::R24:
    case llvm::VideoCore4::GP:
      return "gp";
    case llvm::VideoCore4::R25:
    case llvm::VideoCore4::SP:
      return "sp";
    case llvm::VideoCore4::R26:
    case llvm::VideoCore4::LR:
      return "lr";
    case llvm::VideoCore4::R27:
      return "r27";
    case llvm::VideoCore4::R28:
    case llvm::VideoCore4::ESP:
      return "esp";
    case llvm::VideoCore4::R29:
      return "r29";
    case llvm::VideoCore4::R30:
    case llvm::VideoCore4::SR:
      return "sr";
    case llvm::VideoCore4::R31:
    case llvm::VideoCore4::PC:
      return "pc";
    default:
      llvm_unreachable("cannot get reg name");
    }

    // error
    return nullptr;
  }

  // FIX ME
  inline bool
  isEffectiveInst(unsigned opcode) {
    if (opcode >= llvm::VideoCore4::INSTRUCTION_LIST_END) return false;

    switch (opcode) {
    case llvm::VideoCore4::DBG_VALUE:
    case llvm::VideoCore4::DBG_LABEL:
    case llvm::VideoCore4::PHI:
    case llvm::VideoCore4::IMPLICIT_DEF:
    case llvm::VideoCore4::CFI_INSTRUCTION:
      return false;
    default:
      return true;
    }

    // error
    return true;
  }

  // FIX ME
  inline bool
  isEffectiveMBBI(llvm::MachineBasicBlock::iterator MBBI) {
    unsigned opcode = MBBI->getOpcode();
    if (opcode >= llvm::VideoCore4::INSTRUCTION_LIST_END) return false;

    switch (opcode) {
    case llvm::VideoCore4::DBG_VALUE:
    case llvm::VideoCore4::DBG_LABEL:
    case llvm::VideoCore4::PHI:
    case llvm::VideoCore4::IMPLICIT_DEF:
    case llvm::VideoCore4::CFI_INSTRUCTION:
      return false;
    default:
      return true;
    }

    // error
    return true;
  }

  inline unsigned
  reverseBranch(unsigned opcode) {
    switch (opcode) {
    case llvm::VideoCore4::JMP_CC_EQ:
      return llvm::VideoCore4::JMP_CC_NE;
    case llvm::VideoCore4::JMP_CC_NE:
      return llvm::VideoCore4::JMP_CC_EQ;
    case llvm::VideoCore4::JMP_CC_GT:
      return llvm::VideoCore4::JMP_CC_LE;
    case llvm::VideoCore4::JMP_CC_GE:
      return llvm::VideoCore4::JMP_CC_LT;
    case llvm::VideoCore4::JMP_CC_LT:
      return llvm::VideoCore4::JMP_CC_GE;
    case llvm::VideoCore4::JMP_CC_LE:
      return llvm::VideoCore4::JMP_CC_GT;
    case llvm::VideoCore4::JMP_CC_UGE:
      return llvm::VideoCore4::JMP_CC_ULT;
    case llvm::VideoCore4::JMP_CC_UGT:
      return llvm::VideoCore4::JMP_CC_ULE;
    case llvm::VideoCore4::JMP_CC_ULE:
      return llvm::VideoCore4::JMP_CC_UGT;
    case llvm::VideoCore4::JMP_CC_ULT:
      return llvm::VideoCore4::JMP_CC_UGE;
    default:
      llvm_unreachable("cannot handle this branch");
    }

    // error
    return UINT_MAX;
  }

  inline bool isRawBranch(unsigned opcode) {
    switch (opcode) {
    case llvm::VideoCore4::JMP_CC_EQ:
    case llvm::VideoCore4::JMP_CC_NE:
    case llvm::VideoCore4::JMP_CC_GT:
    case llvm::VideoCore4::JMP_CC_GE:
    case llvm::VideoCore4::JMP_CC_LT:
    case llvm::VideoCore4::JMP_CC_LE:
    case llvm::VideoCore4::JMP_CC_UGT:
    case llvm::VideoCore4::JMP_CC_UGE:
    case llvm::VideoCore4::JMP_CC_ULT:
    case llvm::VideoCore4::JMP_CC_ULE:
      return true;
    default:
      return false;
    }

    // error
    return false;
  }

  inline unsigned
  reverseCmovConditon(unsigned opcode) {
    switch (opcode) {
    case llvm::VideoCore4::CMOV_EQ_RR:
      return llvm::VideoCore4::CMOV_NE_RR;
    case llvm::VideoCore4::CMOV_NE_RR:
      return llvm::VideoCore4::CMOV_EQ_RR;
    case llvm::VideoCore4::CMOV_GT_RR:
      return llvm::VideoCore4::CMOV_LE_RR;
    case llvm::VideoCore4::CMOV_GE_RR:
      return llvm::VideoCore4::CMOV_LT_RR;
    case llvm::VideoCore4::CMOV_LT_RR:
      return llvm::VideoCore4::CMOV_GE_RR;
    case llvm::VideoCore4::CMOV_LE_RR:
      return llvm::VideoCore4::CMOV_GT_RR;
    case llvm::VideoCore4::CMOV_UGE_RR:
      return llvm::VideoCore4::CMOV_ULT_RR;
    case llvm::VideoCore4::CMOV_UGT_RR:
      return llvm::VideoCore4::CMOV_ULE_RR;
    case llvm::VideoCore4::CMOV_ULE_RR:
      return llvm::VideoCore4::CMOV_UGT_RR;
    case llvm::VideoCore4::CMOV_ULT_RR:
      return llvm::VideoCore4::CMOV_UGE_RR;
    default:
      llvm_unreachable("cannot handle this conditional mov");
    }

    // error
    return UINT_MAX;
  }

  static unsigned BranchTakenOpcode[branchKindNum] = {
    llvm::VideoCore4::JMP_COMP_EQ_P,
    llvm::VideoCore4::JMP_COMP_NE_P,
    llvm::VideoCore4::JMP_COMP_GT_P,
    llvm::VideoCore4::JMP_COMP_GE_P,
    llvm::VideoCore4::JMP_COMP_LT_P,
    llvm::VideoCore4::JMP_COMP_LE_P,
    llvm::VideoCore4::JMP_COMP_UGT_P,
    llvm::VideoCore4::JMP_COMP_UGE_P,
    llvm::VideoCore4::JMP_COMP_ULT_P,
    llvm::VideoCore4::JMP_COMP_ULE_P,
    llvm::VideoCore4::JMP_FCOMP_OEQ_P,
    llvm::VideoCore4::JMP_FCOMP_ONE_P,
    llvm::VideoCore4::JMP_FCOMP_OGT_P,
    llvm::VideoCore4::JMP_FCOMP_OGE_P,
    llvm::VideoCore4::JMP_FCOMP_OLT_P,
    llvm::VideoCore4::JMP_FCOMP_OLE_P,
    llvm::VideoCore4::JMP_FCOMP_UEQ_P,
    llvm::VideoCore4::JMP_FCOMP_UNE_P,
    llvm::VideoCore4::JMP_FCOMP_UGT_P,
    llvm::VideoCore4::JMP_FCOMP_UGE_P,
    llvm::VideoCore4::JMP_FCOMP_ULT_P,
    llvm::VideoCore4::JMP_FCOMP_ULE_P
  };
  static unsigned BranchNotTakenOpcode[branchKindNum] = {
    llvm::VideoCore4::JMP_COMP_EQ_F_P,
    llvm::VideoCore4::JMP_COMP_NE_F_P,
    llvm::VideoCore4::JMP_COMP_GT_F_P,
    llvm::VideoCore4::JMP_COMP_GE_F_P,
    llvm::VideoCore4::JMP_COMP_LT_F_P,
    llvm::VideoCore4::JMP_COMP_LE_F_P,
    llvm::VideoCore4::JMP_COMP_UGT_F_P,
    llvm::VideoCore4::JMP_COMP_UGE_F_P,
    llvm::VideoCore4::JMP_COMP_ULT_F_P,
    llvm::VideoCore4::JMP_COMP_ULE_F_P,
    llvm::VideoCore4::JMP_FCOMP_OEQ_F_P,
    llvm::VideoCore4::JMP_FCOMP_ONE_F_P,
    llvm::VideoCore4::JMP_FCOMP_OGT_F_P,
    llvm::VideoCore4::JMP_FCOMP_OGE_F_P,
    llvm::VideoCore4::JMP_FCOMP_OLT_F_P,
    llvm::VideoCore4::JMP_FCOMP_OLE_F_P,
    llvm::VideoCore4::JMP_FCOMP_UEQ_F_P,
    llvm::VideoCore4::JMP_FCOMP_UNE_F_P,
    llvm::VideoCore4::JMP_FCOMP_UGT_F_P,
    llvm::VideoCore4::JMP_FCOMP_UGE_F_P,
    llvm::VideoCore4::JMP_FCOMP_ULT_F_P,
    llvm::VideoCore4::JMP_FCOMP_ULE_F_P
  };

  inline bool
  isRawCondBranch(unsigned opcode) {
    switch (opcode) {
    case llvm::VideoCore4::JMP_CC_EQ:
    case llvm::VideoCore4::JMP_CC_NE:
    case llvm::VideoCore4::JMP_CC_GT:
    case llvm::VideoCore4::JMP_CC_GE:
    case llvm::VideoCore4::JMP_CC_LT:
    case llvm::VideoCore4::JMP_CC_LE:
    case llvm::VideoCore4::JMP_CC_UGT:
    case llvm::VideoCore4::JMP_CC_UGE:
    case llvm::VideoCore4::JMP_CC_ULT:
    case llvm::VideoCore4::JMP_CC_ULE:
      {
	return true;
      }
    default:
      {
	return false;
      }
    }

    return false;
  }

  inline bool
  isCondTrueBranch(unsigned opcode) {
    for (int i=0; i<branchKindNum; i++) {
      if (BranchTakenOpcode[i] == opcode) return true;
    }

    return false;
  }

  inline bool
  isCondFalseBranch(unsigned opcode) {
    for (int i=0; i<branchKindNum; i++) {
      if (BranchNotTakenOpcode[i] == opcode) return true;
    }
    return false;
  }

  inline bool
  isCondBranch(unsigned opcode) {
    if (isCondTrueBranch(opcode)
	|| isCondFalseBranch(opcode)
	|| isRawCondBranch(opcode)) return true;
    return false;
  }

  inline bool
  isUnconditionalJump(unsigned opcode) {
    switch (opcode) {
    case llvm::VideoCore4::JMP32:
    case llvm::VideoCore4::JMPLINK32:
    case llvm::VideoCore4::BR_LINK_G:
    case llvm::VideoCore4::BR_IND_G:
      {
	return true;
      }
    default:
      {
	return false;
      }
    }

    return false;
  }

  inline bool
  isCall(unsigned opcode) {
    return (opcode    == llvm::VideoCore4::CALL
	    || opcode == llvm::VideoCore4::CALL_R);
  }

  inline bool
  isCallMBBI(llvm::MachineBasicBlock::iterator MBBI) {
    return isCall(MBBI->getOpcode());
  }
 
  inline bool
  isReturn(unsigned opcode) {
    return (opcode == llvm::VideoCore4::RET);
  }

  inline bool
  isReturnMBBI(llvm::MachineBasicBlock::iterator MBBI) {
    return isReturn(MBBI->getOpcode());
  }

  inline bool
  isCmp(unsigned opcode) {
    switch (opcode) {
    case llvm::VideoCore4::CMP_F:
    case llvm::VideoCore4::CMP_G:
    case llvm::VideoCore4::CMP_LI:
      {
	return true;
      }
    default:
      {
	return false;
      }
    }

    return false;
  }

  inline bool
  isCmpMBBI(llvm::MachineBasicBlock::iterator MBBI) {
    return isCmp(MBBI->getOpcode());
  }

  inline bool
  isBranch(unsigned opcode) {
    if (isCondBranch(opcode)
	|| isUnconditionalJump(opcode)
	|| isRawBranch(opcode)) return true;
    return false;
  }

  inline bool
  isBranchMBBI(llvm::MachineBasicBlock::iterator MBBI) {
    return isBranch(MBBI->getOpcode());
  }

  inline unsigned
  reverseBranchCondition(llvm::MachineInstr *mi) {
    unsigned reverseOpc = UINT_MAX;
    unsigned opc        = mi->getOpcode();

    for (int i=0; i<branchKindNum; i++) {
      if (opc == BranchTakenOpcode[i]) {
	reverseOpc = BranchNotTakenOpcode[i];
	break;
      } else if (opc == BranchNotTakenOpcode[i]) {
	reverseOpc  = BranchTakenOpcode[i];
	break;
      }
    }

    if (reverseOpc == UINT_MAX) {
      mi->dump();
      llvm_unreachable("cannot handle this branch");
    }

    return reverseOpc;
  }

  namespace CC {
    const int DUMMY = 0;
  }

  inline void
  parseCondBranch(llvm::MachineInstr                          *LastInst,
		  llvm::MachineBasicBlock                    *&Target,
		  llvm::SmallVectorImpl<llvm::MachineOperand> &Cond) {
    Cond.push_back(llvm::MachineOperand::CreateImm(CC::DUMMY));
    Target = LastInst->getOperand(2).getMBB();
  }

  // MI is defined by Other Instruction?
  inline unsigned int
  HasDataDep(const llvm::MachineInstr *MI,
	     const llvm::MachineInstr *Other) {
    for (const auto &MO_Use : MI->uses()) {
      if (!MO_Use.isReg()) continue;

      llvm::Register Reg = MO_Use.getReg();

      if (Other->getOpcode()    == llvm::VideoCore4::CMP_F
	  || Other->getOpcode() == llvm::VideoCore4::CMP_LI) {
	if (Reg == llvm::VideoCore4::SR) {
	  return Reg;
	}
      }

      for (const auto &MO_Def : Other->defs()) {
	if (!MO_Def.isReg()) continue;

	if (MO_Def.getReg() == Reg) {
	  return Reg;
	}
      }
    }

    for (const auto &MO_Def1 : MI->defs()) {
      if (!MO_Def1.isReg()) continue;

      llvm::Register Reg = MO_Def1.getReg();

      for (const auto &MO_Def2 : Other->defs()) {
	if (!MO_Def2.isReg()) continue;

	if (MO_Def2.getReg() == Reg) {
	  return Reg;
	}
      }
    }

    return UINT_MAX;
  }

  inline unsigned int
  HasDataDepForDelaySlot(const llvm::MachineInstr *MI,
			 const llvm::MachineInstr *Other) {
    if (isCall(MI->getOpcode())
	|| isReturn(MI->getOpcode())) return UINT_MAX;
      
    for (const auto &MO_Use : MI->uses()) {
      if (!MO_Use.isReg()) continue;

      llvm::Register Reg = MO_Use.getReg();

      if (Other->getOpcode()    == llvm::VideoCore4::CMP_F
	  || Other->getOpcode() == llvm::VideoCore4::CMP_LI) {
	if (Reg == llvm::VideoCore4::SR) {
	  return Reg;
	}
      }

      for (const auto &MO_Def : Other->defs()) {
	if (!MO_Def.isReg()) continue;

	if (MO_Def.getReg() == Reg) {
	  return Reg;
	}
      }
    }

    for (const auto &MO_Def1 : MI->defs()) {
      if (!MO_Def1.isReg()) continue;

      llvm::Register Reg = MO_Def1.getReg();

      for (const auto &MO_Def2 : Other->defs()) {
	if (!MO_Def2.isReg()) continue;

	if (MO_Def2.getReg() == Reg) {
	  return Reg;
	}
      }
    }

    return UINT_MAX;
  }
} // end namespace vc4util

#endif

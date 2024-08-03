//===-- VideoCore4AsmPrinter.cpp - VideoCore4 LLVM assembly writer -------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains a printer that converts from our internal representation
// of machine-dependent LLVM code to the VideoCore4 assembly language.
//
//===----------------------------------------------------------------------===//

#include "VideoCore4.h"
#include "VideoCore4InstrInfo.h"
#include "VideoCore4MCInstLower.h"
#include "VideoCore4TargetMachine.h"
#include "MCTargetDesc/VideoCore4InstPrinter.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Mangler.h"
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/CodeGen/MachineJumpTableInfo.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

#define DEBUG_TYPE "asm-printer"
#define PASS_DESC  "VideoCore4 Assembly Printer"

namespace llvm {
  class VideoCore4AsmPrinter : public AsmPrinter {
  public:
    explicit VideoCore4AsmPrinter(TargetMachine              &TM,
				  std::unique_ptr<MCStreamer> Streamer)
      : AsmPrinter(TM, std::move(Streamer)) {}
    
    StringRef getPassName() const override {
      return PASS_DESC;
    }
    
    void emitInstruction(const MachineInstr *MI) override;
  };
  
  
  //===----------------------------------------------------------------------===//
  void VideoCore4AsmPrinter::emitInstruction(const MachineInstr *MI) {
    VideoCore4MCInstLower MCInstLowering(OutContext,
					 *this);
    SmallString<256>    Str;
    raw_svector_ostream O(Str);
    
    switch (MI->getOpcode()) {
    case VideoCore4::BR_JT:
      {
	auto regName = VideoCore4InstPrinter::getRegisterName(MI->getOperand(1).getReg());
	
	unsigned                                  JTI   = MI->getOperand(0).getIndex();
	const MachineFunction                    *MF    = MI->getParent()->getParent();
	const MachineJumpTableInfo               *MJTI  = MF->getJumpTableInfo();
	const std::vector<MachineJumpTableEntry> &JT    = MJTI->getJumpTables();
	const std::vector<MachineBasicBlock*>    &JTBBs = JT[JTI].MBBs;
      
	O << "\t# Inline jumptable on "
	  << regName
	  << "\n";
	
	for (unsigned i = 0, e = JTBBs.size(); i != e; ++i) {
	  MachineBasicBlock *MBB = JTBBs[i];
	  O << "\t# Jumptable entry "
	    << i
	    << "\n"	
	    << "\tcmp "
	    << regName
	    << ", "
	    << i
	    << "\n"
	    << "\tbeq "
	    << *MBB->getSymbol()
	    << "\n";
	}
	
	OutStreamer->emitRawText(O.str());
	return;
      }	
    }
    
    MCInst TmpInst;
    MCInstLowering.Lower(MI, TmpInst);
    EmitToStreamer((*OutStreamer), TmpInst);
  }
}

// Force static initialization.
extern "C" void LLVMInitializeVideoCore4AsmPrinter() {
  RegisterAsmPrinter<VideoCore4AsmPrinter> X(TheVideoCore4Target);
}

; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=riscv32 -mattr=+experimental-zfbfmin -verify-machineinstrs \
; RUN:   -target-abi ilp32f < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+experimental-zfbfmin -verify-machineinstrs \
; RUN:   -target-abi lp64f < %s | FileCheck %s

define bfloat @bfloat_imm() nounwind {
; CHECK-LABEL: bfloat_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, %hi(.LCPI0_0)
; CHECK-NEXT:    flh fa0, %lo(.LCPI0_0)(a0)
; CHECK-NEXT:    ret
  ret bfloat 3.0
}

define bfloat @bfloat_imm_op(bfloat %a) nounwind {
; CHECK-LABEL: bfloat_imm_op:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcvt.s.bf16 fa5, fa0
; CHECK-NEXT:    lui a0, 260096
; CHECK-NEXT:    fmv.w.x fa4, a0
; CHECK-NEXT:    fadd.s fa5, fa5, fa4
; CHECK-NEXT:    fcvt.bf16.s fa0, fa5
; CHECK-NEXT:    ret
  %1 = fadd bfloat %a, 1.0
  ret bfloat %1
}

define bfloat @bfloat_zero() nounwind {
; CHECK-LABEL: bfloat_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fmv.h.x fa0, zero
; CHECK-NEXT:    ret
  ret bfloat 0.0
}

define bfloat @bfloat_negative_zero() nounwind {
; CHECK-LABEL: bfloat_negative_zero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lui a0, 1048568
; CHECK-NEXT:    fmv.h.x fa0, a0
; CHECK-NEXT:    ret
  ret bfloat -0.0
}
; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=amdgcn -mcpu=gfx1200 -stop-after=si-fix-sgpr-copies -verify-machineinstrs < %s | FileCheck %s

define amdgpu_kernel void @add_reg_imm(ptr addrspace(1) %ptr) {
  ; CHECK-LABEL: name: add_reg_imm
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr0_sgpr1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:sgpr_64(p4) = COPY $sgpr0_sgpr1
  ; CHECK-NEXT:   [[S_LOAD_DWORDX2_IMM:%[0-9]+]]:sreg_64_xexec = S_LOAD_DWORDX2_IMM [[COPY]](p4), 36, 0 :: (dereferenceable invariant load (s64) from %ir.ptr.kernarg.offset, align 4, addrspace 4)
  ; CHECK-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; CHECK-NEXT:   [[GLOBAL_LOAD_DWORDX2_SADDR:%[0-9]+]]:vreg_64 = GLOBAL_LOAD_DWORDX2_SADDR [[S_LOAD_DWORDX2_IMM]], [[V_MOV_B32_e32_]], 0, 0, implicit $exec :: (volatile "amdgpu-noclobber" load (s64) from %ir.ptr.load, addrspace 1)
  ; CHECK-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 28744523
  ; CHECK-NEXT:   [[S_MOV_B32_1:%[0-9]+]]:sreg_32 = S_MOV_B32 -1395630315
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE killed [[S_MOV_B32_1]], %subreg.sub0, killed [[S_MOV_B32_]], %subreg.sub1
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:sreg_64 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[V_ADD_U:%[0-9]+]]:vreg_64 = V_ADD_U64_PSEUDO [[GLOBAL_LOAD_DWORDX2_SADDR]], killed [[REG_SEQUENCE]], implicit-def $vcc_lo, implicit $exec
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vreg_64 = COPY [[V_ADD_U]]
  ; CHECK-NEXT:   GLOBAL_STORE_DWORDX2_SADDR [[V_MOV_B32_e32_]], killed [[COPY1]], [[S_LOAD_DWORDX2_IMM]], 0, 0, implicit $exec :: (store (s64) into %ir.ptr.load, addrspace 1)
  ; CHECK-NEXT:   S_ENDPGM 0
  %lhs = load volatile i64, ptr addrspace(1) %ptr
  %res = add i64 %lhs, 123456789123456789
  store i64 %res, ptr addrspace(1) %ptr
  ret void
}

define amdgpu_kernel void @add_reg_reg(ptr addrspace(1) %ptr) {
  ; CHECK-LABEL: name: add_reg_reg
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr0_sgpr1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:sgpr_64(p4) = COPY $sgpr0_sgpr1
  ; CHECK-NEXT:   [[S_LOAD_DWORDX2_IMM:%[0-9]+]]:sreg_64_xexec = S_LOAD_DWORDX2_IMM [[COPY]](p4), 36, 0 :: (dereferenceable invariant load (s64) from %ir.ptr.kernarg.offset, align 4, addrspace 4)
  ; CHECK-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; CHECK-NEXT:   [[GLOBAL_LOAD_DWORDX2_SADDR:%[0-9]+]]:vreg_64 = GLOBAL_LOAD_DWORDX2_SADDR [[S_LOAD_DWORDX2_IMM]], [[V_MOV_B32_e32_]], 0, 0, implicit $exec :: (volatile "amdgpu-noclobber" load (s64) from %ir.ptr.load, addrspace 1)
  ; CHECK-NEXT:   [[GLOBAL_LOAD_DWORDX2_SADDR1:%[0-9]+]]:vreg_64 = GLOBAL_LOAD_DWORDX2_SADDR [[S_LOAD_DWORDX2_IMM]], [[V_MOV_B32_e32_]], 0, 0, implicit $exec :: (volatile load (s64) from %ir.ptr.load, addrspace 1)
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:sreg_64 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[DEF1:%[0-9]+]]:sreg_64 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[V_ADD_U:%[0-9]+]]:vreg_64 = V_ADD_U64_PSEUDO [[GLOBAL_LOAD_DWORDX2_SADDR]], [[GLOBAL_LOAD_DWORDX2_SADDR1]], implicit-def $vcc_lo, implicit $exec
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vreg_64 = COPY [[V_ADD_U]]
  ; CHECK-NEXT:   GLOBAL_STORE_DWORDX2_SADDR [[V_MOV_B32_e32_]], killed [[COPY1]], [[S_LOAD_DWORDX2_IMM]], 0, 0, implicit $exec :: (store (s64) into %ir.ptr.load, addrspace 1)
  ; CHECK-NEXT:   S_ENDPGM 0
  %lhs = load volatile i64, ptr addrspace(1) %ptr
  %rhs = load volatile i64, ptr addrspace(1) %ptr
  %res = add i64 %lhs, %rhs
  store i64 %res, ptr addrspace(1) %ptr
  ret void
}

define amdgpu_kernel void @sub_reg_imm(ptr addrspace(1) %ptr) {
  ; CHECK-LABEL: name: sub_reg_imm
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr0_sgpr1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:sgpr_64(p4) = COPY $sgpr0_sgpr1
  ; CHECK-NEXT:   [[S_LOAD_DWORDX2_IMM:%[0-9]+]]:sreg_64_xexec = S_LOAD_DWORDX2_IMM [[COPY]](p4), 36, 0 :: (dereferenceable invariant load (s64) from %ir.ptr.kernarg.offset, align 4, addrspace 4)
  ; CHECK-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; CHECK-NEXT:   [[GLOBAL_LOAD_DWORDX2_SADDR:%[0-9]+]]:vreg_64 = GLOBAL_LOAD_DWORDX2_SADDR [[S_LOAD_DWORDX2_IMM]], [[V_MOV_B32_e32_]], 0, 0, implicit $exec :: (volatile "amdgpu-noclobber" load (s64) from %ir.ptr.load, addrspace 1)
  ; CHECK-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 -28744524
  ; CHECK-NEXT:   [[S_MOV_B32_1:%[0-9]+]]:sreg_32 = S_MOV_B32 1395630315
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE killed [[S_MOV_B32_1]], %subreg.sub0, killed [[S_MOV_B32_]], %subreg.sub1
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:sreg_64 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[V_ADD_U:%[0-9]+]]:vreg_64 = V_ADD_U64_PSEUDO [[GLOBAL_LOAD_DWORDX2_SADDR]], killed [[REG_SEQUENCE]], implicit-def $vcc_lo, implicit $exec
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vreg_64 = COPY [[V_ADD_U]]
  ; CHECK-NEXT:   GLOBAL_STORE_DWORDX2_SADDR [[V_MOV_B32_e32_]], killed [[COPY1]], [[S_LOAD_DWORDX2_IMM]], 0, 0, implicit $exec :: (store (s64) into %ir.ptr.load, addrspace 1)
  ; CHECK-NEXT:   S_ENDPGM 0
  %lhs = load volatile i64, ptr addrspace(1) %ptr
  %res = sub i64 %lhs, 123456789123456789
  store i64 %res, ptr addrspace(1) %ptr
  ret void
}

define amdgpu_kernel void @sub_imm_reg(ptr addrspace(1) %ptr) {
  ; CHECK-LABEL: name: sub_imm_reg
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr0_sgpr1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:sgpr_64(p4) = COPY $sgpr0_sgpr1
  ; CHECK-NEXT:   [[S_LOAD_DWORDX2_IMM:%[0-9]+]]:sreg_64_xexec = S_LOAD_DWORDX2_IMM [[COPY]](p4), 36, 0 :: (dereferenceable invariant load (s64) from %ir.ptr.kernarg.offset, align 4, addrspace 4)
  ; CHECK-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; CHECK-NEXT:   [[GLOBAL_LOAD_DWORDX2_SADDR:%[0-9]+]]:vreg_64 = GLOBAL_LOAD_DWORDX2_SADDR [[S_LOAD_DWORDX2_IMM]], [[V_MOV_B32_e32_]], 0, 0, implicit $exec :: (volatile "amdgpu-noclobber" load (s64) from %ir.ptr.load, addrspace 1)
  ; CHECK-NEXT:   [[S_MOV_B32_:%[0-9]+]]:sreg_32 = S_MOV_B32 28744523
  ; CHECK-NEXT:   [[S_MOV_B32_1:%[0-9]+]]:sreg_32 = S_MOV_B32 -1395630315
  ; CHECK-NEXT:   [[REG_SEQUENCE:%[0-9]+]]:sreg_64 = REG_SEQUENCE killed [[S_MOV_B32_1]], %subreg.sub0, killed [[S_MOV_B32_]], %subreg.sub1
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:sreg_64 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[V_SUB_U:%[0-9]+]]:vreg_64 = V_SUB_U64_PSEUDO killed [[REG_SEQUENCE]], [[GLOBAL_LOAD_DWORDX2_SADDR]], implicit-def $vcc_lo, implicit $exec
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vreg_64 = COPY [[V_SUB_U]]
  ; CHECK-NEXT:   GLOBAL_STORE_DWORDX2_SADDR [[V_MOV_B32_e32_]], killed [[COPY1]], [[S_LOAD_DWORDX2_IMM]], 0, 0, implicit $exec :: (store (s64) into %ir.ptr.load, addrspace 1)
  ; CHECK-NEXT:   S_ENDPGM 0
  %rhs = load volatile i64, ptr addrspace(1) %ptr
  %res = sub i64 123456789123456789, %rhs
  store i64 %res, ptr addrspace(1) %ptr
  ret void
}

define amdgpu_kernel void @sub_reg_reg(ptr addrspace(1) %ptr) {
  ; CHECK-LABEL: name: sub_reg_reg
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $sgpr0_sgpr1
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:sgpr_64(p4) = COPY $sgpr0_sgpr1
  ; CHECK-NEXT:   [[S_LOAD_DWORDX2_IMM:%[0-9]+]]:sreg_64_xexec = S_LOAD_DWORDX2_IMM [[COPY]](p4), 36, 0 :: (dereferenceable invariant load (s64) from %ir.ptr.kernarg.offset, align 4, addrspace 4)
  ; CHECK-NEXT:   [[V_MOV_B32_e32_:%[0-9]+]]:vgpr_32 = V_MOV_B32_e32 0, implicit $exec
  ; CHECK-NEXT:   [[GLOBAL_LOAD_DWORDX2_SADDR:%[0-9]+]]:vreg_64 = GLOBAL_LOAD_DWORDX2_SADDR [[S_LOAD_DWORDX2_IMM]], [[V_MOV_B32_e32_]], 0, 0, implicit $exec :: (volatile "amdgpu-noclobber" load (s64) from %ir.ptr.load, addrspace 1)
  ; CHECK-NEXT:   [[GLOBAL_LOAD_DWORDX2_SADDR1:%[0-9]+]]:vreg_64 = GLOBAL_LOAD_DWORDX2_SADDR [[S_LOAD_DWORDX2_IMM]], [[V_MOV_B32_e32_]], 0, 0, implicit $exec :: (volatile load (s64) from %ir.ptr.load, addrspace 1)
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:sreg_64 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[DEF1:%[0-9]+]]:sreg_64 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[V_SUB_U:%[0-9]+]]:vreg_64 = V_SUB_U64_PSEUDO [[GLOBAL_LOAD_DWORDX2_SADDR]], [[GLOBAL_LOAD_DWORDX2_SADDR1]], implicit-def $vcc_lo, implicit $exec
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vreg_64 = COPY [[V_SUB_U]]
  ; CHECK-NEXT:   GLOBAL_STORE_DWORDX2_SADDR [[V_MOV_B32_e32_]], killed [[COPY1]], [[S_LOAD_DWORDX2_IMM]], 0, 0, implicit $exec :: (store (s64) into %ir.ptr.load, addrspace 1)
  ; CHECK-NEXT:   S_ENDPGM 0
  %lhs = load volatile i64, ptr addrspace(1) %ptr
  %rhs = load volatile i64, ptr addrspace(1) %ptr
  %res = sub i64 %lhs, %rhs
  store i64 %res, ptr addrspace(1) %ptr
  ret void
}

// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py

// REQUIRES: aarch64-registered-target

// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -p mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -triple aarch64-none-linux-gnu -target-feature +sme2 -S -disable-O0-optnone -Werror -Wall -o /dev/null %s

#include <arm_sme.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// BMOPA

// CHECK-LABEL: @test_svbmopa_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PN:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PM:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.bmopa.za32.nxv4i32(i32 3, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i1> [[TMP1]], <vscale x 4 x i32> [[ZN:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z16test_svbmopa_u32u10__SVBool_tS_u12__SVUint32_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PN:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PM:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.bmopa.za32.nxv4i32(i32 3, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i1> [[TMP1]], <vscale x 4 x i32> [[ZN:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret void
//
void test_svbmopa_u32(svbool_t pn, svbool_t pm, svuint32_t zn, svuint32_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svbmopa_za32,_u32,_m,)(3, pn, pm, zn, zm);
}

// CHECK-LABEL: @test_svbmopa_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PN:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PM:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.bmopa.za32.nxv4i32(i32 3, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i1> [[TMP1]], <vscale x 4 x i32> [[ZN:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z16test_svbmopa_s32u10__SVBool_tS_u11__SVInt32_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PN:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PM:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.bmopa.za32.nxv4i32(i32 3, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i1> [[TMP1]], <vscale x 4 x i32> [[ZN:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret void
//
void test_svbmopa_s32(svbool_t pn, svbool_t pm, svint32_t zn, svint32_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svbmopa_za32,_s32,_m,)(3, pn, pm, zn, zm);
}

// BMOPS

// CHECK-LABEL: @test_svbmops_u32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PN:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PM:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.bmops.za32.nxv4i32(i32 3, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i1> [[TMP1]], <vscale x 4 x i32> [[ZN:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z16test_svbmops_u32u10__SVBool_tS_u12__SVUint32_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PN:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PM:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.bmops.za32.nxv4i32(i32 3, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i1> [[TMP1]], <vscale x 4 x i32> [[ZN:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret void
//
void test_svbmops_u32(svbool_t pn, svbool_t pm, svuint32_t zn, svuint32_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svbmops_za32,_u32,_m,)(3, pn, pm, zn, zm);
}

// CHECK-LABEL: @test_svbmops_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PN:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PM:%.*]])
// CHECK-NEXT:    tail call void @llvm.aarch64.sme.bmops.za32.nxv4i32(i32 3, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i1> [[TMP1]], <vscale x 4 x i32> [[ZN:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z16test_svbmops_s32u10__SVBool_tS_u11__SVInt32_tS0_(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PN:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PM:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.aarch64.sme.bmops.za32.nxv4i32(i32 3, <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i1> [[TMP1]], <vscale x 4 x i32> [[ZN:%.*]], <vscale x 4 x i32> [[ZM:%.*]])
// CPP-CHECK-NEXT:    ret void
//
void test_svbmops_s32(svbool_t pn, svbool_t pm, svint32_t zn, svint32_t zm) __arm_streaming __arm_inout("za") {
  SVE_ACLE_FUNC(svbmops_za32,_s32,_m,)(3, pn, pm, zn, zm);
}
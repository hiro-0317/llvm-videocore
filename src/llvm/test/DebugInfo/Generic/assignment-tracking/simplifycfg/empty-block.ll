; RUN: opt -S %s -passes=simplifycfg -o - \
; RUN: | FileCheck %s
; RUN: opt --try-experimental-debuginfo-iterators -S %s -passes=simplifycfg -o - \
; RUN: | FileCheck %s

;; $ cat test.cpp
;; class a {};
;; void operator*(a, float &);
;; class b {
;; public:
;;   a c;
;; };
;; int d;
;; class e {
;;   b g[3];
;;   float f;
;;   void i();
;; };
;; void e::i() {
;;   float h;
;;   g[d].c *h;
;;   if (h)
;;     h = f;
;;   else
;;     h = f;
;; }
;; Generated by grabbing IR before simplifycfg in:
;; $ clang++ -O2 -g -c test.cpp -Xclang -fexperimental-assignment-tracking

;; if.then and if.else each only have a dbg.assign and br instruction.
;; SimplifyCFG will remove these blocks. Check that the dbg.assign intrinsics
;; are sunk into the succ beforehand.

; CHECK: entry:
;; -- alloca dbg.assign
; CHECK: call void @llvm.dbg.assign(metadata i1 undef
;; -- sunk dbg.assigns
; CHECK: call void @llvm.dbg.assign(metadata float undef, metadata ![[var:[0-9]+]], metadata !DIExpression(), metadata ![[id:[0-9]+]], metadata ptr %h, metadata !DIExpression()), !dbg
; CHECK-NEXT: call void @llvm.dbg.assign(metadata float undef, metadata ![[var]], metadata !DIExpression(), metadata ![[id]], metadata ptr %h, metadata !DIExpression()), !dbg
; CHECK-NEXT: %storemerge.in = getelementptr
; CHECK-NEXT: %storemerge = load float
; CHECK-NEXT: store float %storemerge, ptr %h, align 4{{.+}}!DIAssignID ![[id]]
; CHECK: ret void

%class.e = type { [3 x %class.b], float }
%class.b = type { %class.a }
%class.a = type { i8 }

@d = dso_local local_unnamed_addr global i32 0, align 4, !dbg !0

; Function Attrs: uwtable
define dso_local void @_ZN1e1iEv(ptr %this) local_unnamed_addr #0 align 2 !dbg !11 {
entry:
  %h = alloca float, align 4, !DIAssignID !32
  call void @llvm.dbg.assign(metadata i1 undef, metadata !31, metadata !DIExpression(), metadata !32, metadata ptr %h, metadata !DIExpression()), !dbg !33
  %0 = bitcast ptr %h to ptr, !dbg !34
  call void @llvm.lifetime.start.p0i8(i64 4, ptr nonnull %0) #4, !dbg !34
  call void @_Zml1aRf(ptr nonnull align 4 dereferenceable(4) %h), !dbg !35
  %1 = load float, ptr %h, align 4, !dbg !36
  %tobool = fcmp une float %1, 0.000000e+00, !dbg !36
  br i1 %tobool, label %if.then, label %if.else, !dbg !42

if.then:                                          ; preds = %entry
  call void @llvm.dbg.assign(metadata float undef, metadata !31, metadata !DIExpression(), metadata !43, metadata ptr %h, metadata !DIExpression()), !dbg !33
  br label %if.end, !dbg !44

if.else:                                          ; preds = %entry
  call void @llvm.dbg.assign(metadata float undef, metadata !31, metadata !DIExpression(), metadata !43, metadata ptr %h, metadata !DIExpression()), !dbg !33
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %storemerge.in = getelementptr inbounds %class.e, ptr %this, i64 0, i32 1, !dbg !45
  %storemerge = load float, ptr %storemerge.in, align 4, !dbg !45
  store float %storemerge, ptr %h, align 4, !dbg !45, !DIAssignID !43
  call void @llvm.lifetime.end.p0i8(i64 4, ptr nonnull %0) #4, !dbg !48
  ret void, !dbg !48
}

declare void @llvm.lifetime.start.p0i8(i64 immarg, ptr nocapture) #1
declare !dbg !49 dso_local void @_Zml1aRf(ptr nonnull align 4 dereferenceable(4)) local_unnamed_addr #2
declare void @llvm.lifetime.end.p0i8(i64 immarg, ptr nocapture) #1
declare void @llvm.dbg.assign(metadata, metadata, metadata, metadata, metadata, metadata) #3

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8, !9, !1000}
!llvm.ident = !{!10}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "d", scope: !2, file: !3, line: 7, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !3, producer: "clang version 12.0.0", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "test.cpp", directory: "/")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{i32 7, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = !{!"clang version 12.0.0"}
!11 = distinct !DISubprogram(name: "i", linkageName: "_ZN1e1iEv", scope: !12, file: !3, line: 13, type: !25, scopeLine: 13, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, declaration: !24, retainedNodes: !28)
!12 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "e", file: !3, line: 8, size: 64, flags: DIFlagTypePassByValue, elements: !13, identifier: "_ZTS1e")
!13 = !{!14, !22, !24}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "g", scope: !12, file: !3, line: 9, baseType: !15, size: 24)
!15 = !DICompositeType(tag: DW_TAG_array_type, baseType: !16, size: 24, elements: !20)
!16 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "b", file: !3, line: 3, size: 8, flags: DIFlagTypePassByValue, elements: !17, identifier: "_ZTS1b")
!17 = !{!18}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !16, file: !3, line: 5, baseType: !19, size: 8, flags: DIFlagPublic)
!19 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "a", file: !3, line: 1, size: 8, flags: DIFlagTypePassByValue, elements: !4, identifier: "_ZTS1a")
!20 = !{!21}
!21 = !DISubrange(count: 3)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "f", scope: !12, file: !3, line: 10, baseType: !23, size: 32, offset: 32)
!23 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!24 = !DISubprogram(name: "i", linkageName: "_ZN1e1iEv", scope: !12, file: !3, line: 11, type: !25, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!25 = !DISubroutineType(types: !26)
!26 = !{null, !27}
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!28 = !{!29, !31}
!29 = !DILocalVariable(name: "this", arg: 1, scope: !11, type: !30, flags: DIFlagArtificial | DIFlagObjectPointer)
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!31 = !DILocalVariable(name: "h", scope: !11, file: !3, line: 14, type: !23)
!32 = distinct !DIAssignID()
!33 = !DILocation(line: 0, scope: !11)
!34 = !DILocation(line: 14, column: 3, scope: !11)
!35 = !DILocation(line: 15, column: 10, scope: !11)
!36 = !DILocation(line: 16, column: 7, scope: !37)
!37 = distinct !DILexicalBlock(scope: !11, file: !3, line: 16, column: 7)
!42 = !DILocation(line: 16, column: 7, scope: !11)
!43 = distinct !DIAssignID()
!44 = !DILocation(line: 17, column: 5, scope: !37)
!45 = !DILocation(line: 0, scope: !37)
!48 = !DILocation(line: 20, column: 1, scope: !11)
!49 = !DISubprogram(name: "operator*", linkageName: "_Zml1aRf", scope: !3, file: !3, line: 2, type: !50, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized, retainedNodes: !4)
!50 = !DISubroutineType(types: !51)
!51 = !{null, !19, !52}
!52 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !23, size: 64)
!1000 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
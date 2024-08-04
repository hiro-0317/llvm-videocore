	.text
	.file	"llvm_select.cpp"
	.globl	test_movx_1                     # -- Begin function test_movx_1
	.p2align	2
	.type	test_movx_1,@function
test_movx_1:                            # @test_movx_1
# %bb.0:
	sub	%sp, 4                          # encoding: [0x00,0x00]
	mov	%r1, 1                          # encoding: [0x00,0x00]
	st	%r1, 0 (sp)                     # encoding: [0x00,0x00,0x00,0x00]
	ld	%r2, 0 (sp)                     # encoding: [0x00,0x00,0x00,0x00]
	mov	%r3, 0                          # encoding: [0x00,0x00]
	cmp	%r2, %r3                        # encoding: [0x00,0x28]
	mov	%r0, 3                          # encoding: [0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 4                          # encoding: [0x80,0x08]
	moveq	%r0, %r1                        # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	test_movx_1, ($func_end0)-test_movx_1
                                        # -- End function
	.globl	test_movx_2                     # -- Begin function test_movx_2
	.p2align	2
	.type	test_movx_2,@function
test_movx_2:                            # @test_movx_2
# %bb.0:
	sub	%sp, 4                          # encoding: [0x00,0x00]
	mov	%r0, 1                          # encoding: [0x00,0x00]
	st	%r0, 0 (sp)                     # encoding: [0x00,0x00,0x00,0x00]
	ld	%r1, 0 (sp)                     # encoding: [0x00,0x00,0x00,0x00]
	mov	%r2, 0                          # encoding: [0x00,0x00]
	mov	%r3, 3                          # encoding: [0x00,0x00]
	cmp	%r1, %r2                        # encoding: [0x00,0x28]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 4                          # encoding: [0x80,0x08]
	moveq	%r0, %r3                        # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end1:
	.size	test_movx_2, ($func_end1)-test_movx_2
                                        # -- End function
	.globl	test_movx_3                     # -- Begin function test_movx_3
	.p2align	2
	.type	test_movx_3,@function
test_movx_3:                            # @test_movx_3
# %bb.0:
	lea	%r0, _MergedGlobals(%pc)        # encoding: []
                                        #   fixup A - offset: 0, value: _MergedGlobals, kind: fixup_VideoCore4_32
	ld	%r1, (%r0)                      # encoding: [0x00,0x00]
	ld	%r2, (%r0)                      # encoding: [0x00,0x00]
	mov	%r3, 1                          # encoding: [0x00,0x00]
	cmp	%r1, %r2                        # encoding: [0x00,0x28]
	mov	%r0, 2                          # encoding: [0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	movlt	%r0, %r3                        # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end2:
	.size	test_movx_3, ($func_end2)-test_movx_3
                                        # -- End function
	.globl	test_movx_4                     # -- Begin function test_movx_4
	.p2align	2
	.type	test_movx_4,@function
test_movx_4:                            # @test_movx_4
# %bb.0:
	lea	%r0, _MergedGlobals(%pc)        # encoding: []
                                        #   fixup A - offset: 0, value: _MergedGlobals, kind: fixup_VideoCore4_32
	ld	%r1, (%r0)                      # encoding: [0x00,0x00]
	mov	%r2, 0                          # encoding: [0x00,0x00]
	mov	%r3, 3                          # encoding: [0x00,0x00]
	cmp	%r1, %r2                        # encoding: [0x00,0x28]
	mov	%r0, 1                          # encoding: [0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	moveq	%r0, %r3                        # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end3:
	.size	test_movx_4, ($func_end3)-test_movx_4
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	sub	%sp, 4                          # encoding: [0x00,0x00]
	bl	test_movx_1                     # encoding: [0x00,0x00,0x00,0x00]
	st	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	lea	%r2, dst(%pc)                   # encoding: []
                                        #   fixup A - offset: 0, value: dst, kind: fixup_VideoCore4_32
	bl	test_movx_2                     # encoding: [0x00,0x00,0x00,0x00]
	st	%r0, (%r2)                      # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	bl	test_movx_3                     # encoding: [0x00,0x00,0x00,0x00]
	st	%r0, (%r2)                      # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	bl	test_movx_4                     # encoding: [0x00,0x00,0x00,0x00]
	st	%r0, (%r2)                      # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	mov	%r1, 0                          # encoding: [0x00,0x00]
	st	%r0, (%r2)                      # encoding: [0x00,0x00]
	ld	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 4                          # encoding: [0x80,0x08]
	mov	%r0, %r1                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end4:
	.size	main, ($func_end4)-main
                                        # -- End function
	.type	dst,@object                     # @dst
	.data
	.globl	dst
	.p2align	2, 0x0
dst:
	.space	16
	.size	dst, 16

	.type	_MergedGlobals,@object          # @_MergedGlobals
	.p2align	2, 0x0
_MergedGlobals:
	.long	1                               # 0x1
	.long	2                               # 0x2
	.size	_MergedGlobals, 8

	.globl	a
.set a, _MergedGlobals
	.size	a, 4
	.globl	b
.set b, _MergedGlobals+4
	.size	b, 4
	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git 2f8c3f7f648a83d43d5f06935fbd4bdc1fb55d1e)"
	.section	".note.GNU-stack","",@progbits

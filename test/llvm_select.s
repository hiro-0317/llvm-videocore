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
	cmp	%r2, %r3                        # encoding: []
	mov	%r0, 3                          # encoding: [0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 4                          # encoding: [0x00,0x00]
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
	cmp	%r1, %r2                        # encoding: []
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 4                          # encoding: [0x00,0x00]
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
	lea	%r0, a(%pc)                     # encoding: []
                                        #   fixup A - offset: 0, value: a, kind: fixup_VideoCore4_32
	ld	%r1, (%r0)                      # encoding: [0x00,0x00]
	lea	%r0, b(%pc)                     # encoding: []
                                        #   fixup A - offset: 0, value: b, kind: fixup_VideoCore4_32
	ld	%r2, (%r0)                      # encoding: [0x00,0x00]
	mov	%r3, 1                          # encoding: [0x00,0x00]
	cmp	%r1, %r2                        # encoding: []
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
	lea	%r0, a(%pc)                     # encoding: []
                                        #   fixup A - offset: 0, value: a, kind: fixup_VideoCore4_32
	ld	%r1, (%r0)                      # encoding: [0x00,0x00]
	mov	%r2, 0                          # encoding: [0x00,0x00]
	mov	%r3, 3                          # encoding: [0x00,0x00]
	cmp	%r1, %r2                        # encoding: []
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
	add	%sp, 4                          # encoding: [0x00,0x00]
	mov	%r0, %r1                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end4:
	.size	main, ($func_end4)-main
                                        # -- End function
	.type	a,@object                       # @a
	.data
	.globl	a
	.p2align	2, 0x0
a:
	.long	1                               # 0x1
	.size	a, 4

	.type	b,@object                       # @b
	.globl	b
	.p2align	2, 0x0
b:
	.long	2                               # 0x2
	.size	b, 4

	.type	dst,@object                     # @dst
	.globl	dst
	.p2align	2, 0x0
dst:
	.space	16
	.size	dst, 16

	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git fa850fa4b45c11a3f4df7e48370277bb06861c36)"
	.section	".note.GNU-stack","",@progbits

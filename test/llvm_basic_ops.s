	.text
	.file	"llvm_basic_ops.cpp"
	.globl	test_basic_ops                  # -- Begin function test_basic_ops
	.p2align	2
	.type	test_basic_ops,@function
test_basic_ops:                         # @test_basic_ops
# %bb.0:
	ld	%r3, (%r1)                      # encoding: [0x00,0x00]
	ld	%r4, (%r2)                      # encoding: [0x00,0x00]
	add	%r4, %r3                        # encoding: [0x00,0x00]
	st	%r4, (%r0)                      # encoding: [0x00,0x00]
	ld	%r3, 4 (%r1)                    # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 4 (%r2)                    # encoding: [0x00,0x00,0x00,0x00]
	sub	%r3, %r4                        # encoding: [0x00,0x00]
	st	%r3, 4 (%r0)                    # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 8 (%r1)                    # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 8 (%r2)                    # encoding: [0x00,0x00,0x00,0x00]
	mul	%r4, %r3                        # encoding: [0x00,0x00]
	st	%r4, 8 (%r0)                    # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 12 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 12 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	lsr	%r3, %r4                        # encoding: [0x00,0x00]
	st	%r3, 12 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 16 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 16 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	lsl	%r3, %r4                        # encoding: [0x00,0x00]
	st	%r3, 16 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 20 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 20 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	and	%r4, %r3                        # encoding: [0x00,0x00]
	st	%r4, 20 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 24 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 24 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	or	%r4, %r3                        # encoding: [0x00,0x00]
	st	%r4, 24 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 28 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 28 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	eor	%r4, %r3                        # encoding: [0x00,0x00]
	st	%r4, 28 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 32 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 32 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	cmp	%r3, %r4                        # encoding: []
	mov	%r3, 0                          # encoding: [0x00,0x00]
	moveq	%r3, 1                          # encoding: [0x00,0x00,0x00,0x00]
	st	%r3, 32 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 36 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 36 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	cmp	%r3, %r4                        # encoding: []
	mov	%r3, 0                          # encoding: [0x00,0x00]
	movne	%r3, 1                          # encoding: [0x00,0x00,0x00,0x00]
	st	%r3, 36 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 40 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 40 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	cmp	%r3, %r4                        # encoding: []
	mov	%r3, 0                          # encoding: [0x00,0x00]
	movult	%r3, 1                          # encoding: [0x00,0x00,0x00,0x00]
	st	%r3, 40 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 44 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 44 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	cmp	%r3, %r4                        # encoding: []
	mov	%r3, 0                          # encoding: [0x00,0x00]
	movule	%r3, 1                          # encoding: [0x00,0x00,0x00,0x00]
	st	%r3, 44 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 48 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 48 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	cmp	%r3, %r4                        # encoding: []
	mov	%r3, 0                          # encoding: [0x00,0x00]
	movugt	%r3, 1                          # encoding: [0x00,0x00,0x00,0x00]
	ld	%r1, 52 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r2, 52 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	cmp	%r1, %r2                        # encoding: []
	mov	%r1, 0                          # encoding: [0x00,0x00]
	movuge	%r1, 1                          # encoding: [0x00,0x00,0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	st	%r1, 52 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	st	%r3, 48 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	test_basic_ops, ($func_end0)-test_basic_ops
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	sub	%sp, 4                          # encoding: [0x00,0x00]
	lea	%r0, res(%pc)                   # encoding: []
                                        #   fixup A - offset: 0, value: res, kind: fixup_VideoCore4_32
	bl	test_basic_ops                  # encoding: [0x00,0x00,0x00,0x00]
	st	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	lea	%r2, rhs(%pc)                   # encoding: []
                                        #   fixup A - offset: 0, value: rhs, kind: fixup_VideoCore4_32
	lea	%r1, lhs(%pc)                   # encoding: []
                                        #   fixup A - offset: 0, value: lhs, kind: fixup_VideoCore4_32
	ld	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 4                          # encoding: [0x00,0x00]
	mov	%r0, 0                          # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end1:
	.size	main, ($func_end1)-main
                                        # -- End function
	.type	lhs,@object                     # @lhs
	.data
	.globl	lhs
	.p2align	2, 0x0
lhs:
	.space	56
	.size	lhs, 56

	.type	rhs,@object                     # @rhs
	.globl	rhs
	.p2align	2, 0x0
rhs:
	.space	56
	.size	rhs, 56

	.type	res,@object                     # @res
	.globl	res
	.p2align	2, 0x0
res:
	.space	56
	.size	res, 56

	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git fa850fa4b45c11a3f4df7e48370277bb06861c36)"
	.section	".note.GNU-stack","",@progbits

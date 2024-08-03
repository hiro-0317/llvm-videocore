	.text
	.file	"llvm_basic_ops.cpp"
	.globl	test_basic_ops                  # -- Begin function test_basic_ops
	.p2align	2
	.type	test_basic_ops,@function
test_basic_ops:                         # @test_basic_ops
# %bb.0:
	ld	%r3, (%r1)                      # encoding: [0x00,0x00]
	ld	%r4, (%r2)                      # encoding: [0x00,0x00]
	add	%r3, %r4                        # encoding: [0x00,0x08]
	st	%r3, (%r0)                      # encoding: [0x00,0x00]
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
	cmp	%r3, %r4                        # encoding: [0x00,0x28]
	mov	%r3, 0                          # encoding: [0x00,0x00]
	moveq	%r3, 1                          # encoding: [0x00,0x00,0x00,0x00]
	st	%r3, 32 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 36 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 36 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	cmp	%r3, %r4                        # encoding: [0x00,0x28]
	mov	%r3, 0                          # encoding: [0x00,0x00]
	movne	%r3, 1                          # encoding: [0x00,0x00,0x00,0x00]
	st	%r3, 36 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 40 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 40 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	cmp	%r3, %r4                        # encoding: [0x00,0x28]
	mov	%r3, 0                          # encoding: [0x00,0x00]
	movult	%r3, 1                          # encoding: [0x00,0x00,0x00,0x00]
	st	%r3, 40 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 44 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 44 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	cmp	%r3, %r4                        # encoding: [0x00,0x28]
	mov	%r3, 0                          # encoding: [0x00,0x00]
	movule	%r3, 1                          # encoding: [0x00,0x00,0x00,0x00]
	st	%r3, 44 (%r0)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r3, 48 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r4, 48 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	cmp	%r3, %r4                        # encoding: [0x00,0x28]
	mov	%r3, 0                          # encoding: [0x00,0x00]
	movugt	%r3, 1                          # encoding: [0x00,0x00,0x00,0x00]
	ld	%r1, 52 (%r1)                   # encoding: [0x00,0x00,0x00,0x00]
	ld	%r2, 52 (%r2)                   # encoding: [0x00,0x00,0x00,0x00]
	cmp	%r1, %r2                        # encoding: [0x00,0x28]
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
	lea	%r0, _MergedGlobals(%pc)        # encoding: []
                                        #   fixup A - offset: 0, value: _MergedGlobals, kind: fixup_VideoCore4_32
	bl	test_basic_ops                  # encoding: [0x00,0x00,0x00,0x00]
	mov	%r2, %r0                        # encoding: [0x00,0x00]
	mov	%r1, %r0                        # encoding: [0x00,0x00]
	st	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	ld	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 4                          # encoding: [0x04,0x00,0x00,0xb0]
	mov	%r0, 0                          # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end1:
	.size	main, ($func_end1)-main
                                        # -- End function
	.type	_MergedGlobals,@object          # @_MergedGlobals
	.data
	.p2align	2, 0x0
_MergedGlobals:
	.space	168
	.size	_MergedGlobals, 168

	.globl	lhs
.set lhs, _MergedGlobals
	.size	lhs, 56
	.globl	rhs
.set rhs, _MergedGlobals+56
	.size	rhs, 56
	.globl	res
.set res, _MergedGlobals+112
	.size	res, 56
	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git 342a13f79e947df06d66f5532d6d20367e7b9e37)"
	.section	".note.GNU-stack","",@progbits

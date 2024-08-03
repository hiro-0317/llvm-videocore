	.text
	.file	"llvm_gcd.cpp"
	.globl	gcd                             # -- Begin function gcd
	.p2align	2
	.type	gcd,@function
gcd:                                    # @gcd
# %bb.0:
	cmp	%r0, %r1                        # encoding: []
	beq	BB0_3                           # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
# %bb.1:                                # %.preheader
	mov	%r2, %r0                        # encoding: [0x00,0x00]
	mov	%r3, 0                          # encoding: [0x00,0x00]
BB0_2:                                  # =>This Inner Loop Header: Depth=1
	mov	%r4, %r3                        # encoding: [0x00,0x00]
	cmp	%r1, %r2                        # encoding: []
	movlt	%r4, %r1                        # encoding: [0x00,0x00,0x00,0x00]
	cmp	%r1, %r2                        # encoding: []
	movlt	%r2, %r3                        # encoding: [0x00,0x00,0x00,0x00]
	sub	%r0, %r4                        # encoding: [0x00,0x00]
	sub	%r1, %r2                        # encoding: [0x00,0x00]
	cmp	%r0, %r1                        # encoding: []
	bne	BB0_2                           # encoding: [0x00,0x00,0x00,0x00]
	mov	%r2, %r0                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
BB0_3:
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	gcd, ($func_end0)-gcd
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	lea	%r2, _MergedGlobals(%pc)        # encoding: []
                                        #   fixup A - offset: 0, value: _MergedGlobals, kind: fixup_VideoCore4_32
	sub	%sp, 4                          # encoding: [0x00,0x00]
	ld	%r0, (%r2)                      # encoding: [0x00,0x00]
	bl	gcd                             # encoding: [0x00,0x00,0x00,0x00]
	mov	%r1, %r0                        # encoding: [0x00,0x00]
	st	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	ld	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 4                          # encoding: []
	st	%r0, (%r2)                      # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end1:
	.size	main, ($func_end1)-main
                                        # -- End function
	.type	_MergedGlobals,@object          # @_MergedGlobals
	.data
	.p2align	2, 0x0
_MergedGlobals:
	.long	1071                            # 0x42f
	.long	1029                            # 0x405
	.long	0                               # 0x0
	.size	_MergedGlobals, 12

	.globl	src0
.set src0, _MergedGlobals
	.size	src0, 4
	.globl	src1
.set src1, _MergedGlobals+4
	.size	src1, 4
	.globl	dst
.set dst, _MergedGlobals+8
	.size	dst, 4
	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git 53b826ea2f21e301f3ef6484b4fa8814a7c4f185)"
	.section	".note.GNU-stack","",@progbits

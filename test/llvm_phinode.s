	.text
	.file	"llvm_phinode.cpp"
	.globl	llvm_phinode                    # -- Begin function llvm_phinode
	.p2align	2
	.type	llvm_phinode,@function
llvm_phinode:                           # @llvm_phinode
# %bb.0:
	cmp	%r0, 0                          # encoding: []
	beq	BB0_4                           # encoding: [0x00,0x00,0x00,0x00]
	mov	%r3, 1                          # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
# %bb.1:
	cmp	%r1, 0                          # encoding: []
	beq	BB0_3                           # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
# %bb.2:
	add	%r3, %r0, -1                    # encoding: []
BB0_4:
	add	%r3, %r3, %r1                   # encoding: []
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	mov	%r0, %r3                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
BB0_3:
	mov	%r4, 0                          # encoding: [0x00,0x00]
	add	%r3, %r0, 2                     # encoding: []
	cmp	%r2, %r4                        # encoding: []
	moveq	%r0, %r3                        # encoding: [0x00,0x00,0x00,0x00]
	mov	%r3, %r0                        # encoding: [0x00,0x00]
	add	%r3, %r3, %r1                   # encoding: []
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	mov	%r0, %r3                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	llvm_phinode, ($func_end0)-llvm_phinode
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	lea	%r3, _MergedGlobals(%pc)        # encoding: []
                                        #   fixup A - offset: 0, value: _MergedGlobals, kind: fixup_VideoCore4_32
	sub	%sp, 4                          # encoding: [0x00,0x00]
	ld	%r0, (%r3)                      # encoding: [0x00,0x00]
	bl	llvm_phinode                    # encoding: [0x00,0x00,0x00,0x00]
	mov	%r2, %r0                        # encoding: [0x00,0x00]
	mov	%r1, %r0                        # encoding: [0x00,0x00]
	st	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	ld	%r1, (%r3)                      # encoding: [0x00,0x00]
	st	%r0, (%r3)                      # encoding: [0x00,0x00]
	bl	llvm_phinode                    # encoding: [0x00,0x00,0x00,0x00]
	mov	%r2, %r1                        # encoding: [0x00,0x00]
	mov	%r0, %r1                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	ld	%r1, (%r3)                      # encoding: [0x00,0x00]
	st	%r0, (%r3)                      # encoding: [0x00,0x00]
	bl	llvm_phinode                    # encoding: [0x00,0x00,0x00,0x00]
	mov	%r2, %r1                        # encoding: [0x00,0x00]
	mov	%r0, %r1                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	ld	%r1, (%r3)                      # encoding: [0x00,0x00]
	st	%r0, (%r3)                      # encoding: [0x00,0x00]
	bl	llvm_phinode                    # encoding: [0x00,0x00,0x00,0x00]
	mov	%r2, %r1                        # encoding: [0x00,0x00]
	mov	%r0, %r1                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	ld	%r1, (%r3)                      # encoding: [0x00,0x00]
	st	%r0, (%r3)                      # encoding: [0x00,0x00]
	bl	llvm_phinode                    # encoding: [0x00,0x00,0x00,0x00]
	mov	%r2, %r1                        # encoding: [0x00,0x00]
	mov	%r0, %r1                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	ld	%r1, (%r3)                      # encoding: [0x00,0x00]
	st	%r0, (%r3)                      # encoding: [0x00,0x00]
	bl	llvm_phinode                    # encoding: [0x00,0x00,0x00,0x00]
	mov	%r2, %r1                        # encoding: [0x00,0x00]
	mov	%r0, %r1                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	ld	%r1, (%r3)                      # encoding: [0x00,0x00]
	st	%r0, (%r3)                      # encoding: [0x00,0x00]
	bl	llvm_phinode                    # encoding: [0x00,0x00,0x00,0x00]
	mov	%r2, %r1                        # encoding: [0x00,0x00]
	mov	%r0, %r1                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	ld	%r1, (%r3)                      # encoding: [0x00,0x00]
	st	%r0, (%r3)                      # encoding: [0x00,0x00]
	bl	llvm_phinode                    # encoding: [0x00,0x00,0x00,0x00]
	mov	%r2, %r1                        # encoding: [0x00,0x00]
	mov	%r0, %r1                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	mov	%r1, 0                          # encoding: [0x00,0x00]
	st	%r0, (%r3)                      # encoding: [0x00,0x00]
	ld	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, %sp, 4                     # encoding: []
	mov	%r0, %r1                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end1:
	.size	main, ($func_end1)-main
                                        # -- End function
	.type	_MergedGlobals,@object          # @_MergedGlobals
	.data
	.p2align	2, 0x0
_MergedGlobals:
	.space	128
	.size	_MergedGlobals, 128

	.globl	a
.set a, _MergedGlobals
	.size	a, 32
	.globl	b
.set b, _MergedGlobals+32
	.size	b, 32
	.globl	c
.set c, _MergedGlobals+64
	.size	c, 32
	.globl	dst
.set dst, _MergedGlobals+96
	.size	dst, 32
	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git 3940490f1427ad624ec4acf4daee903fbc364e6a)"
	.section	".note.GNU-stack","",@progbits

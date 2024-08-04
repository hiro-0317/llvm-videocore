	.text
	.file	"llvm_frameadj.cpp"
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	sub	%sp, 1200                       # encoding: [0x00,0x00]
	mov	%r0, 0                          # encoding: [0x00,0x00]
	add	%r1, %sp, 400                   # encoding: []
	add	%r2, %sp, 0                     # encoding: []
	add	%r3, %sp, 800                   # encoding: []
BB0_1:                                  # =>This Inner Loop Header: Depth=1
	mov	%r4, %r0                        # encoding: [0x00,0x00]
	add	%r4, %r1                        # encoding: [0x00,0x08]
	mov	%r5, %r0                        # encoding: [0x00,0x00]
	add	%r5, %r2                        # encoding: [0x00,0x08]
	ld	%r4, (%r4)                      # encoding: [0x00,0x00]
	ld	%r5, (%r5)                      # encoding: [0x00,0x00]
	add	%r4, %r5                        # encoding: [0x00,0x08]
	mov	%r5, %r0                        # encoding: [0x00,0x00]
	add	%r5, %r3                        # encoding: [0x00,0x08]
	add	%r0, 4                          # encoding: [0x04,0x00,0x00,0xb0]
	cmp	%r0, 400                        # encoding: []
	bne	BB0_1                           # encoding: [0x00,0x00,0x00,0x00]
	st	%r4, (%r5)                      # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
# %bb.2:
	mov	%r0, 0                          # encoding: [0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 1200                       # encoding: [0xb0,0x04,0x00,0xb0]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	main, ($func_end0)-main
                                        # -- End function
	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git 227a8d07b4d45051689d072091d549a5ebae1708)"
	.section	".note.GNU-stack","",@progbits

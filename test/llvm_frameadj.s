	.text
	.file	"llvm_frameadj.cpp"
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	sub	%sp, 1200                       # encoding: [0xb0,0x04,0xc0,0xb0]
	mov	%r0, 0                          # encoding: [0x00,0x00]
	add	%r1, %sp, 400                   # encoding: [0x90,0x01,0x00,0x00,0x00,0x08]
	add	%r2, %sp, 0                     # encoding: [0x00,0x00,0x00,0x00,0x00,0x08]
	add	%r3, %sp, 800                   # encoding: [0x20,0x03,0x00,0x00,0x00,0x08]
BB0_1:                                  # =>This Inner Loop Header: Depth=1
	mov	%r4, %r0                        # encoding: [0x00,0x40]
	add	%r4, %r1                        # encoding: [0x00,0x42]
	mov	%r5, %r0                        # encoding: [0x00,0x40]
	add	%r5, %r2                        # encoding: [0x00,0x42]
	ld	%r4, (%r4)                      # encoding: [0x00,0x00]
	ld	%r5, (%r5)                      # encoding: [0x00,0x00]
	add	%r4, %r5                        # encoding: [0x00,0x42]
	mov	%r5, %r0                        # encoding: [0x00,0x40]
	add	%r5, %r3                        # encoding: [0x00,0x42]
	add	%r0, 4                          # encoding: [0x40,0x62]
	cmp	%r0, 400                        # encoding: [0x00,0x00,0x00,0x00,0x00,0x00]
	bne	BB0_1                           # encoding: [0x00,0x00,0x00,0x00]
	st	%r4, (%r5)                      # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
# %bb.2:
	mov	%r0, 0                          # encoding: [0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 1200                       # encoding: [0xb0,0x04,0x40,0xb0]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	main, ($func_end0)-main
                                        # -- End function
	.ident	"clang version 19.1.2 (git@github.com:hiro-0317/llvm-videocore.git a40909d18e63f0231e11989283ee7663915e36cf)"
	.section	".note.GNU-stack","",@progbits

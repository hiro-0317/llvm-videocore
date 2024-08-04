	.text
	.file	"llvm_cttz.cpp"
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	mov	%r1, 0                          # encoding: [0x00,0x00]
	lea	%r0, dst(%pc)                   # encoding: [0x00,0x00,0x00,0x00,0x00,0xe5]
                                        #   fixup A - offset: 0, value: dst, kind: fixup_VideoCore4_32
BB0_1:                                  # =>This Inner Loop Header: Depth=1
	add	%r2, %r1, -1                    # encoding: [0xff,0xff,0xff,0xff,0x00,0x08]
	add	%r3, %r1, 1                     # encoding: [0x01,0x00,0x00,0x00,0x00,0x08]
	not	%r1, %r1                        # encoding: [0x00,0x00]
	and	%r1, %r2                        # encoding: [0x00,0x1c]
	count	%r1, %r1                        # encoding: [0x00,0xc0]
	st	%r1, (%r0)                      # encoding: [0x00,0x00]
	cmp	%r3, 4096                       # encoding: [0x00,0x00,0x00,0x00,0x00,0x00]
	bne	BB0_1                           # encoding: [0x00,0x00,0x00,0x00]
	mov	%r1, %r3                        # encoding: [0x00,0x00]
	add	%r0, 4                          # encoding: [0x80,0x08]
	nop                                     # encoding: [0x01,0x00]
# %bb.2:
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	mov	%r0, 0                          # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	main, ($func_end0)-main
                                        # -- End function
	.type	dst,@object                     # @dst
	.data
	.globl	dst
	.p2align	2, 0x0
dst:
	.space	16384
	.size	dst, 16384

	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git 8026ba373f9a75bbf4a378c8edde4b9f9a7bbffc)"
	.section	".note.GNU-stack","",@progbits

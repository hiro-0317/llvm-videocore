	.text
	.file	"llvm_memmove.cpp"
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %copy_backwards
	mov	%r0, 0                          # encoding: [0x00,0x00]
	lea	%r1, dst(%pc)                   # encoding: []
                                        #   fixup A - offset: 0, value: dst, kind: fixup_VideoCore4_32
BB0_1:                                  # %copy_backwards_loop
                                        # =>This Inner Loop Header: Depth=1
	ldb	%r2, (%r0, %r1)                 # encoding: [0x00,0x00,0x00,0x00]
	stb	%r2, (%r0, %r1)                 # encoding: [0x00,0x00,0x00,0x00]
	add	%r0, -1                         # encoding: [0x00,0x00]
	cmp	%r0, -992                       # encoding: []
	bne	BB0_1                           # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
# %bb.2:                                # %memmove_done
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
	.long	16909060                        # 0x1020304
	.space	4092
	.size	dst, 4096

	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git 39f0627d2764247659c81c93e720d516f367f604)"
	.section	".note.GNU-stack","",@progbits

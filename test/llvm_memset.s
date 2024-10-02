	.text
	.file	"llvm_memset.cpp"
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	mov	%r0, 0                          # encoding: [0x00,0x00]
	lea	%r1, dst(%pc)                   # encoding: [0x00,0x00,0x00,0x00,0x00,0xe5]
                                        #   fixup A - offset: 0, value: dst, kind: fixup_VideoCore4_32
	mov	%r2, 1                          # encoding: [0x00,0x00]
BB0_1:                                  # %loadstoreloop
                                        # =>This Inner Loop Header: Depth=1
	stb	%r2, (%r0, %r1)                 # encoding: [0x00,0x00,0x00,0x00]
	add	%r0, 1                          # encoding: [0x10,0x62]
	cmp	%r0, 4096                       # encoding: [0x00,0x00,0x00,0x00,0x00,0x00]
	bult	BB0_1                           # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
# %bb.2:                                # %split
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
	.space	4096
	.size	dst, 4096

	.ident	"clang version 19.1.1 (git@github.com:hiro-0317/llvm-videocore.git 96b93a055ce8b1123cb636a954d8d6cdc9069b6c)"
	.section	".note.GNU-stack","",@progbits

	.text
	.file	"llvm_memcpy.cpp"
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	mov	%r0, 0                          # encoding: [0x00,0x00]
	lea	%r1, src(%pc)                   # encoding: [0x00,0x00,0x00,0x00,0x00,0xe5,0x00,0x00]
                                        #   fixup A - offset: 0, value: src, kind: fixup_VideoCore4_32
	lea	%r2, dst(%pc)                   # encoding: [0x00,0x00,0x00,0x00,0x00,0xe5,0x00,0x00]
                                        #   fixup A - offset: 0, value: dst, kind: fixup_VideoCore4_32
BB0_1:                                  # %load-store-loop
                                        # =>This Inner Loop Header: Depth=1
	ldb	%r3, (%r0, %r1)                 # encoding: [0x00,0x00,0x00,0x00]
	stb	%r3, (%r0, %r2)                 # encoding: [0x00,0x00,0x00,0x00]
	add	%r0, 1                          # encoding: [0x20,0x08]
	cmp	%r0, 4096                       # encoding: [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
	bult	BB0_1                           # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
# %bb.2:                                # %memcpy-split
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	mov	%r0, 0                          # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	main, ($func_end0)-main
                                        # -- End function
	.type	src,@object                     # @src
	.data
	.globl	src
	.p2align	2, 0x0
src:
	.space	4096
	.size	src, 4096

	.type	dst,@object                     # @dst
	.globl	dst
	.p2align	2, 0x0
dst:
	.space	4096
	.size	dst, 4096

	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git 546f933925869dce37889df1fa9d3bae6c5276f6)"
	.section	".note.GNU-stack","",@progbits

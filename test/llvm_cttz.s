	.text
	.file	"llvm_cttz.cpp"
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	mov	%r0, 0                          # encoding: [0x00,0x00]
	lea	%r1, dst(%pc)                   # encoding: []
                                        #   fixup A - offset: 0, value: dst, kind: fixup_VideoCore4_32
BB0_1:                                  # =>This Inner Loop Header: Depth=1
	mov	%r2, %r0                        # encoding: [0x00,0x00]
	mov	%r3, %r0                        # encoding: [0x00,0x00]
	add	%r2, %r2, -1                    # encoding: []
	not	%r3, %r3                        # encoding: [0x00,0x00]
	and	%r3, %r2                        # encoding: [0x00,0x00]
	count	%r2, %r3                        # encoding: []
	add	%r0, %r0, 1                     # encoding: []
	st	%r2, (%r1)                      # encoding: [0x00,0x00]
	cmp	%r0, 4096                       # encoding: []
	bne	BB0_1                           # encoding: [0x00,0x00,0x00,0x00]
	add	%r1, %r1, 4                     # encoding: []
	nop                                     # encoding: [0x01,0x00]
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

	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git ebc1c10f7d5b7e631c35550a14a9c66cf3131985)"
	.section	".note.GNU-stack","",@progbits
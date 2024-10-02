	.text
	.file	"llvm_localpointer.cpp"
	.globl	llvm_local_pointer              # -- Begin function llvm_local_pointer
	.p2align	2
	.type	llvm_local_pointer,@function
llvm_local_pointer:                     # @llvm_local_pointer
# %bb.0:
	sub	%sp, 4                          # encoding: [0x04,0x00,0xc0,0xb0]
	mov	%r0, 3                          # encoding: [0x00,0x00]
	st	%r0, 0 (sp)                     # encoding: [0x00,0x00,0x00,0x00]
	ld	%r0, 0 (sp)                     # encoding: [0x00,0x00,0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 4                          # encoding: [0x04,0x00,0x40,0xb0]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	llvm_local_pointer, ($func_end0)-llvm_local_pointer
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	sub	%sp, 4                          # encoding: [0x04,0x00,0xc0,0xb0]
	bl	llvm_local_pointer              # encoding: [0x00,0x00,0x00,0x00]
	st	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	ld	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	lea	%r1, dst(%pc)                   # encoding: [0x00,0x00,0x00,0x00,0x00,0xe5]
                                        #   fixup A - offset: 0, value: dst, kind: fixup_VideoCore4_32
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 4                          # encoding: [0x04,0x00,0x40,0xb0]
	st	%r0, (%r1)                      # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end1:
	.size	main, ($func_end1)-main
                                        # -- End function
	.type	dst,@object                     # @dst
	.data
	.globl	dst
	.p2align	2, 0x0
dst:
	.long	0                               # 0x0
	.size	dst, 4

	.ident	"clang version 19.1.1 (git@github.com:hiro-0317/llvm-videocore.git 96b93a055ce8b1123cb636a954d8d6cdc9069b6c)"
	.section	".note.GNU-stack","",@progbits

	.text
	.file	"sub.cpp"
	.globl	add                             # -- Begin function add
	.p2align	2
	.type	add,@function
add:                                    # @add
# %bb.0:
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%r0, %r1                        # encoding: [0x00,0x08]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	add, ($func_end0)-add
                                        # -- End function
	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git 227a8d07b4d45051689d072091d549a5ebae1708)"
	.section	".note.GNU-stack","",@progbits

	.text
	.file	"sub.cpp"
	.globl	add                             # -- Begin function add
	.p2align	2
	.type	add,@function
add:                                    # @add
# %bb.0:
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%r0, %r1                        # encoding: [0x00,0x42]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	add, ($func_end0)-add
                                        # -- End function
	.ident	"clang version 19.1.3 (git@github.com:hiro-0317/llvm-videocore.git b4c12b19cd9bb67fe8df3d2b05f3be6e9bd5167a)"
	.section	".note.GNU-stack","",@progbits

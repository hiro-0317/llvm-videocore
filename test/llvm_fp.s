	.text
	.file	"llvm_fp.cpp"
	.globl	_Z4testPff                      # -- Begin function _Z4testPff
	.p2align	2
	.type	_Z4testPff,@function
_Z4testPff:                             # @_Z4testPff
# %bb.0:
	fmul	%r1, %r1, %r1                   # encoding: [0x00,0x00,0x00,0x00]
	st	%r1, (%r0)                      # encoding: [0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	mov	%r0, %r1                        # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	_Z4testPff, ($func_end0)-_Z4testPff
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	itof	%r0, %r0                        # encoding: [0x00,0x00,0x00,0x00]
	sub	%sp, 4                          # encoding: [0x00,0x00]
	fmul	%r0, %r0, %r0                   # encoding: [0x00,0x00,0x00,0x00]
	st	%r0, 0 (sp)                     # encoding: [0x00,0x00,0x00,0x00]
	ld	%r0, 0 (sp)                     # encoding: [0x00,0x00,0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, %sp, 4                     # encoding: []
	ftoi	%r0, %r0                        # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end1:
	.size	main, ($func_end1)-main
                                        # -- End function
	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git ebc1c10f7d5b7e631c35550a14a9c66cf3131985)"
	.section	".note.GNU-stack","",@progbits
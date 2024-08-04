	.text
	.file	"llvm_recursive_fact.cpp"
	.globl	_Z14recursive_facti             # -- Begin function _Z14recursive_facti
	.p2align	2
	.type	_Z14recursive_facti,@function
_Z14recursive_facti:                    # @_Z14recursive_facti
# %bb.0:
	cmp	%r0, 0                          # encoding: [0x00,0x00,0x00,0x00,0x00,0x00]
	beq	BB0_2                           # encoding: [0x00,0x00,0x00,0x00]
	mov	%r1, 1                          # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
BB0_1:                                  # =>This Inner Loop Header: Depth=1
	add	%r2, %r0, -1                    # encoding: [0xff,0xff,0xff,0xff,0x00,0x08]
	cmp	%r2, 0                          # encoding: [0x00,0x00,0x00,0x00,0x00,0x00]
	mul	%r1, %r0                        # encoding: [0x00,0x44]
	bne	BB0_1                           # encoding: [0x00,0x00,0x00,0x00]
	mov	%r0, %r2                        # encoding: [0x00,0x40]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
BB0_2:
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	mov	%r0, %r1                        # encoding: [0x00,0x40]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	_Z14recursive_facti, ($func_end0)-_Z14recursive_facti
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	lea	%r1, _MergedGlobals(%pc)        # encoding: [0x00,0x00,0x00,0x00,0x00,0xe5]
                                        #   fixup A - offset: 0, value: _MergedGlobals, kind: fixup_VideoCore4_32
	ld	%r2, (%r1)                      # encoding: [0x00,0x00]
	cmp	%r2, 0                          # encoding: [0x00,0x00,0x00,0x00,0x00,0x00]
	beq	BB1_2                           # encoding: [0x00,0x00,0x00,0x00]
	mov	%r0, 1                          # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
BB1_1:                                  # =>This Inner Loop Header: Depth=1
	add	%r3, %r2, -1                    # encoding: [0xff,0xff,0xff,0xff,0x00,0x08]
	cmp	%r3, 0                          # encoding: [0x00,0x00,0x00,0x00,0x00,0x00]
	mul	%r0, %r2                        # encoding: [0x00,0x44]
	bne	BB1_1                           # encoding: [0x00,0x00,0x00,0x00]
	mov	%r2, %r3                        # encoding: [0x00,0x40]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
BB1_2:
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	st	%r0, (%r1)                      # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end1:
	.size	main, ($func_end1)-main
                                        # -- End function
	.type	_MergedGlobals,@object          # @_MergedGlobals
	.data
	.p2align	2, 0x0
_MergedGlobals:
	.long	7                               # 0x7
	.long	0                               # 0x0
	.size	_MergedGlobals, 8

	.globl	src
.set src, _MergedGlobals
	.size	src, 4
	.globl	dst
.set dst, _MergedGlobals+4
	.size	dst, 4
	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git 239c171f99cd7dfa8e8cb8a18f830482d232b662)"
	.section	".note.GNU-stack","",@progbits

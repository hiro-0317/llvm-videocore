	.text
	.file	"llvm_assignment.cpp"
	.globl	assignment                      # -- Begin function assignment
	.p2align	2
	.type	assignment,@function
assignment:                             # @assignment
# %bb.0:
	lea	%r0, _MergedGlobals(%pc)        # encoding: []
                                        #   fixup A - offset: 0, value: _MergedGlobals, kind: fixup_VideoCore4_32
	ld	%r1, (%r0)                      # encoding: [0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	st	%r1, (%r0)                      # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	assignment, ($func_end0)-assignment
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	sub	%sp, 4                          # encoding: [0x00,0x00]
	bl	assignment                      # encoding: [0x00,0x00,0x00,0x00]
	st	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	ld	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, 4                          # encoding: []
	mov	%r0, 0                          # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end1:
	.size	main, ($func_end1)-main
                                        # -- End function
	.type	_MergedGlobals,@object          # @_MergedGlobals
	.data
	.p2align	2, 0x0
_MergedGlobals:
	.space	8
	.long	127                             # 0x7f
	.long	0                               # 0x0
	.long	255                             # 0xff
	.long	0                               # 0x0
	.long	65535                           # 0xffff
	.long	0                               # 0x0
	.long	4294967232                      # 0xffffffc0
	.long	0                               # 0x0
	.long	63                              # 0x3f
	.long	0                               # 0x0
	.long	4294967168                      # 0xffffff80
	.long	0                               # 0x0
	.long	127                             # 0x7f
	.long	0                               # 0x0
	.long	4294934528                      # 0xffff8000
	.long	0                               # 0x0
	.long	32767                           # 0x7fff
	.long	0                               # 0x0
	.size	_MergedGlobals, 80

	.globl	data_unsigned
.set data_unsigned, _MergedGlobals
	.size	data_unsigned, 32
	.globl	data_signed
.set data_signed, _MergedGlobals+32
	.size	data_signed, 48
	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git ed68c9e378c993fe9f15ff68aafbd7b041715036)"
	.section	".note.GNU-stack","",@progbits

	.text
	.file	"main.cpp"
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	sub	%sp, 4                          # encoding: [0x00,0x00]
	bl	add                             # encoding: [0x00,0x00,0x00,0x00]
	st	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	mov	%r1, 6                          # encoding: [0x00,0x00]
	mov	%r0, 5                          # encoding: [0x00,0x00]
	ld	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	lea	%r1, x(%pc)                     # encoding: []
                                        #   fixup A - offset: 0, value: x, kind: fixup_VideoCore4_32
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, %sp, 4                     # encoding: []
	st	%r0, (%r1)                      # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	main, ($func_end0)-main
                                        # -- End function
	.type	x,@object                       # @x
	.bss
	.globl	x
	.p2align	2, 0x0
x:
	.long	0                               # 0x0
	.size	x, 4

	.type	y,@object                       # @y
	.data
	.globl	y
	.p2align	2, 0x0
y:
	.long	1                               # 0x1
	.size	y, 4

	.type	z,@object                       # @z
	.bss
	.globl	z
	.p2align	2, 0x0
z:
	.long	0                               # 0x0
	.size	z, 4

	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git ebc1c10f7d5b7e631c35550a14a9c66cf3131985)"
	.section	".note.GNU-stack","",@progbits
	.text
	.file	"llvm_sra.cpp"
	.globl	_sra                            # -- Begin function _sra
	.p2align	2
	.type	_sra,@function
_sra:                                   # @_sra
# %bb.0:
	cmp	%r1, 0                          # encoding: []
	bne	BB0_1                           # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
# %bb.1:                                # %.preheader
	add	%r0, %r0, 8                     # encoding: []
BB0_2:                                  # =>This Inner Loop Header: Depth=1
	add	%r2, %r0, -8                    # encoding: []
	add	%r3, %r0, -4                    # encoding: []
	ld	%r2, (%r2)                      # encoding: [0x00,0x00]
	ld	%r3, (%r3)                      # encoding: [0x00,0x00]
	asr	%r2, %r3                        # encoding: [0x00,0x00]
	add	%r1, %r1, -1                    # encoding: []
	st	%r2, (%r0)                      # encoding: [0x00,0x00]
	cmp	%r1, 0                          # encoding: []
	bne	BB0_2                           # encoding: [0x00,0x00,0x00,0x00]
	add	%r0, %r0, 12                    # encoding: []
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
BB0_3:
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end0:
	.size	_sra, ($func_end0)-_sra
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	sub	%sp, 4                          # encoding: [0x00,0x00]
	bl	_sra                            # encoding: [0x00,0x00,0x00,0x00]
	st	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	mov	%r1, 27                         # encoding: [0x00,0x00]
	lea	%r0, p(%pc)                     # encoding: []
                                        #   fixup A - offset: 0, value: p, kind: fixup_VideoCore4_32
	ld	%lr, 0 (%sp)                    # 4-byte Folded Spill
                                        # encoding: [0x00,0x00,0x00,0x00]
	b	%lr                             # encoding: [0x00,0x00,0x00,0x00]
	add	%sp, %sp, 4                     # encoding: []
	mov	%r0, 0                          # encoding: [0x00,0x00]
	nop                                     # encoding: [0x01,0x00]
$func_end1:
	.size	main, ($func_end1)-main
                                        # -- End function
	.type	p,@object                       # @p
	.data
	.globl	p
	.p2align	2, 0x0
p:
	.long	1024                            # 0x400
	.long	0                               # 0x0
	.long	1024                            # 0x400
	.long	1024                            # 0x400
	.long	1                               # 0x1
	.long	512                             # 0x200
	.long	1024                            # 0x400
	.long	2                               # 0x2
	.long	256                             # 0x100
	.long	1024                            # 0x400
	.long	3                               # 0x3
	.long	128                             # 0x80
	.long	1024                            # 0x400
	.long	4                               # 0x4
	.long	64                              # 0x40
	.long	1024                            # 0x400
	.long	5                               # 0x5
	.long	32                              # 0x20
	.long	1024                            # 0x400
	.long	6                               # 0x6
	.long	16                              # 0x10
	.long	1024                            # 0x400
	.long	7                               # 0x7
	.long	8                               # 0x8
	.long	1024                            # 0x400
	.long	8                               # 0x8
	.long	4                               # 0x4
	.long	1024                            # 0x400
	.long	9                               # 0x9
	.long	2                               # 0x2
	.long	1024                            # 0x400
	.long	10                              # 0xa
	.long	1                               # 0x1
	.long	1024                            # 0x400
	.long	11                              # 0xb
	.long	0                               # 0x0
	.long	1024                            # 0x400
	.long	12                              # 0xc
	.long	0                               # 0x0
	.long	1024                            # 0x400
	.long	31                              # 0x1f
	.long	0                               # 0x0
	.long	4294966272                      # 0xfffffc00
	.long	1                               # 0x1
	.long	4294966784                      # 0xfffffe00
	.long	4294966272                      # 0xfffffc00
	.long	2                               # 0x2
	.long	4294967040                      # 0xffffff00
	.long	4294966272                      # 0xfffffc00
	.long	3                               # 0x3
	.long	4294967168                      # 0xffffff80
	.long	4294966272                      # 0xfffffc00
	.long	4                               # 0x4
	.long	4294967232                      # 0xffffffc0
	.long	4294966272                      # 0xfffffc00
	.long	5                               # 0x5
	.long	4294967264                      # 0xffffffe0
	.long	4294966272                      # 0xfffffc00
	.long	6                               # 0x6
	.long	4294967280                      # 0xfffffff0
	.long	4294966272                      # 0xfffffc00
	.long	7                               # 0x7
	.long	4294967288                      # 0xfffffff8
	.long	4294966272                      # 0xfffffc00
	.long	8                               # 0x8
	.long	4294967292                      # 0xfffffffc
	.long	4294966272                      # 0xfffffc00
	.long	9                               # 0x9
	.long	4294967294                      # 0xfffffffe
	.long	4294966272                      # 0xfffffc00
	.long	10                              # 0xa
	.long	4294967295                      # 0xffffffff
	.long	4294966272                      # 0xfffffc00
	.long	11                              # 0xb
	.long	4294967295                      # 0xffffffff
	.long	4294966272                      # 0xfffffc00
	.long	12                              # 0xc
	.long	4294967295                      # 0xffffffff
	.long	4294966272                      # 0xfffffc00
	.long	31                              # 0x1f
	.long	4294967295                      # 0xffffffff
	.size	p, 324

	.ident	"clang version 18.1.8 (git@github.com:hiro-0317/llvm-videocore.git 61ca638a20edfde469649d6fe03b517dfe46de0a)"
	.section	".note.GNU-stack","",@progbits

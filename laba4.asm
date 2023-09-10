 org $8000
 
 ldaa #$ff
 ldx #$2200
 ldab #$00
Initialization
	stab $0,x
	inx
	incb
	deca
	bne Initialization

 ldaa #$ff
 ldx #$2200
 ldab #$00
Counter
	brclr 0,x,#$01,True
	inx
	deca
	bne Counter
	bra Finish
True
	inx
	incb
	deca
	bne Counter
	bra Finish
Finish
	nop
 	nop
 	nop	
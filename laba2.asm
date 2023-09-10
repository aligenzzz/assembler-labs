 org $8000

 ldaa #$11
 ldab #$22
 ldx #$3333
 ldy #$ffff
 
 staa $0
 stab $1
 stx $2
 sty $4
 
 ldd #0
 addb $0
 adca #0
 addb $1
 adca #0
 addb $2
 adca #0
 addb $3
 adca #0
 addb $4
 adca #0
 addb $5
 adca #0
 

 org $8000

 ldx #0
 ldaa #%00000000
 ldab #%11111111
 
 staa $21,x
 stab $22,x

 tab
 andb #%10000000
 pshb
 lsra
 tab
 andb #%00100000
 pshb
 lsra
 tab
 andb #%00001000
 pshb
 lsra
 tab
 andb #%00000010
 pshb

 ldaa $21,x
 lsla
 lsla
 lsla
 lsla

 tab
 andb #%10000000
 pshb
 lsra
 tab
 andb #%00100000
 pshb
 lsra
 tab
 andb #%00001000
 pshb
 lsra
 tab
 andb #%00000010
 pshb

 clra
 clrb
 pulb
 aba
 pulb
 aba
 pulb
 aba
 pulb
 aba
 staa $24,x
 clra
 clrb
 pulb
 aba
 pulb
 aba
 pulb
 aba
 pulb
 aba
 staa $23,x

 ldaa $22,x
 lsra
 tab
 andb #%01000000
 pshb
 lsra
 tab
 andb #%00010000
 pshb
 lsra
 tab
 andb #%00000100
 pshb
 lsra
 tab
 andb #%00000001
 pshb

 ldaa $22,x
 lsla
 lsla
 lsla

 tab
 andb #%01000000
 pshb
 lsra
 tab
 andb #%00010000
 pshb
 lsra
 tab
 andb #%00000100
 pshb
 lsra
 tab
 andb #%00000001
 pshb

 clra
 clrb
 pulb
 aba
 pulb
 aba
 pulb
 aba
 pulb
 aba
 staa $26,x
 clra
 clrb
 pulb
 aba
 pulb
 aba
 pulb
 aba
 pulb
 aba
 staa $25,x

 ldaa $23,x
 adca $25,x
 ldab $24,x
 adcb $26,x
 xgdx
 
 

 
 
 
 
 
 
 
 
 
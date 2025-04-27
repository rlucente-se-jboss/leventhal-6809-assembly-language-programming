; Problem 7-5. ASCII string to binary number

; Convert the eight ASCII characters in memory locations $42 through
; $49 to an 8-bit binary number in memory location $41 (the most
; significant bit is in $42). Clear memory location $40 if all the
; ASCII characters are either ASCII 1 or ASCII 0 and set it to $FF
; otherwise.

        setdp   0
        org     $4000

start:
        bsr     ascbin
        lda     #$37
        sta     $45
        clr     result
        clr     errcod

ascbin:
        ldx     #data
        clrb
        stb     result
        lda     #$ff
        sta     errcod
conv:
        lda     ,x+
        cmpa    #$30
        blo     error
        cmpa    #$31
        bhi     error
        rora
        rolb
        cmpx    #dataend
        bne     conv

        stb     result
        clr     errcod
error:
        rts

        org     $40
errcod  fcb     0
result  fcb     0
data    fcc     '11010010'
dataend rmb     0

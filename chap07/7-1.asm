; 7-1. hexadecimal to ascii

; Convert the contents of memory location $40 to an ASCII character.
; Memory location $40 contains a single hexadecimal digit (the four
; most significant bits are zero). Store the ASCII character in memory
; location $41.

ASCA    equ     'A
ASC9    equ     '9
ASC0    equ     '0

        org     $4000
        setdp   0

        bsr     hexasc

        lda     #$06
        sta     <digit
        clr     <result

hexasc  lda     <digit
        cmpa    #9
        bls     ascz
        adda    #ASCA-ASC9-1
ascz    adda    #ASC0
        ora     #$40            ; ASCII to VDGSCII
        sta     <result

        rts

        org     $40
digit   fcb     $0c
result  fcb     0


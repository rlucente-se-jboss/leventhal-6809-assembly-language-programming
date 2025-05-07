; 7-1b. hexadecimal to ascii

; Convert the contents of memory location $40 to an ASCII character.
; Memory location $40 contains a single hexadecimal digit (the four
; most significant bits are zero). Store the ASCII character in memory
; location $41. This uses alternate BCD method with no branching.

        org     $4000
        setdp   0

        bsr     hexasc

        lda     #$06
        sta     <digit
        clr     <result

hexasc  lda     <digit
        adda    #$90
        daa
        adca    #$40
        daa
        sta     <result

        rts

        org     $40
digit   fcb     $0c
result  fcb     0


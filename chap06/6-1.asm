; 6-1. length of a string of characters

; Determine the length of a string of characters. The string starts
; in memory location $41; the end of the string is marked by an ASCII
; carriage return character ('CR', 0D). Place the length of the string
; (excluding the carriage return) into memory location $40.

CR      equ     $0d

        org     $4000
        setdp   0

        bsr     strlen
        lda     #CR
        sta     <pointer

strlen  ldx     #pointer
        clrb
        lda     #CR

chkcr   cmpa    ,x+
        beq     done
        incb
        bra     chkcr

done    stb     <length
        rts

        org     $40
length  rmb     1
pointer fcc     'RATHER'
        fcb     CR

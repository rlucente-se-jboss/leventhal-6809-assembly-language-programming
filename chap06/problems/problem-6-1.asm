; Problem 6-1. length of a teletypewriter message

; Determine the length of an ASCIl message. All characters are 7-bit
; ASCII with MSB = 0. The string of characters in which the message
; is embedded starts in memory location $41. The message itself starts
; with an ASCII MSTX character (02) and ends with METX (03). Place
; the length of the message (the number of characters between the
; MSTX and the METX but including neither) into memory location $40.

MSTX    equ     $02
METX    equ     $03

        org     $4000
        setdp   0

        ldx     #data
        lda     #MSTX
wtstx   cmpa    ,x+
        bne     wtstx

        ldb     #$ff
        lda     #METX

wtetx   incb
        cmpa    ,x+
        bne     wtetx

        stb     <result
        rts

        org     $40
result  rmb     1
data    fcb     $40,$02
        fcc     'GO'
        fcb     $03

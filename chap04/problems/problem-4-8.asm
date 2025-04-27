; Problem 4-8. 24-bit addition

; Add the 24-bit number in memory locations $40, $41, and $42 to
; the 24-bit number in memory locations $43, $44, and $45. The most
; significant bytes are in memory locations $40 and $43, the least
; significant bytes in memory locations $42 and $45. Store the result
; in memory locations $46, $47, and $48 with the most significant
; byte in memory location $46 and the least significant byte in $48.

        org $4000
        setdp 0

        lda     $42     ; get lower byte of first operand
        adda    $45     ; add lower byte of second operand
        sta     $48     ; save result of lower byte

        lda     $41     ; get middle byte of first operand
        adca    $44     ; add carry and middle byte of second operand
        sta     $47     ; save result of middle byte

        lda     $40     ; get high byte of first operand
        adca    $43     ; add carry and high byte of second operand
        sta     $46     ; save result of high byte

        rts

        org     $40
        fcb     $35,$67,$2a,$51,$a4,$f8,0,0,0

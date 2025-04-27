; 4-7. find larger of two numbers

; Place the larger of the contents of memory locations $40 and $41
; in memory location $42. Assume that memory locations $40 and $41
; contain unsigned binary numbers.

        org     $4000
        setdp   0

        bsr     larger

        lda     #$75
        sta     $40
        lda     #$a8
        sta     $41

larger  lda     $40     ; get first operand
        cmpa    $41     ; is second operand larger?
        bhs     stres
        lda     $41     ; yes, get second operand
stres   sta     $42     ; store larger operand
        rts

        org     $40
        fcb     $3f
        fcb     $2b

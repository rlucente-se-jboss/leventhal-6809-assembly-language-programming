; Problem 4-7. Find smaller of two numbers

; Place the smaller of the contents of memory locations $40 and $41
; in memory location $42. Assume that memory locations $40 and $41
; contain unsigned binary numbers.

        org $4000
        setdp 0

        bsr     fndsml

        ldd     #$75a8
        std     $40
        clr     $42

fndsml  lda     $40     ; get first operand
        cmpa    $41     ; compare to second operand (e.g. (a) - (m))
        bls     stres   ; branch if A is lower or the same
        lda     $41
stres   sta     $42

        rts

        org     $40
        fcb     $3f,$2b,0

; 4-2. 8-bit addition

; Add the contents of memory locations $40 and $41, and place the
; result in memory location $42.

        org     $4000
        setdp   0

start   lda     $40     ; get first operand
        adda    $41     ; add second operand
        sta     $42     ; store result
        rts

        org     $40
        fcb     $38
        fcb     $2b
        fcb     $00

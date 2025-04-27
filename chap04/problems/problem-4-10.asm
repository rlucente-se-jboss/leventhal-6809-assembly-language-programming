; Problem 4-10. 16-bit twos complement

; Place the twos complement of the 16-bit number in memory locations
; $40 and $41 (most significant bits in $40) in memory locations $42
; and $43 (most significant bits in $42). The twos complement of a
; number is the number that, when added to the original number,
; produces a result of zero; the twos complement is also equal to the
; ones complement plus one, since the sum of a number and its ones
; complement is the all ones word.

        org $4000
        setdp 0

        bsr     twocom
        bsr     subcom

        ldx     #$40
        lda     #$72
        sta     ,x+
        clra
        sta     ,x

        bsr     twocom

; this has fewer cycles and fewer bytes
subcom  ldd     #0      ; clear d
        subd    $40     ; 0 - x
        std     $42
        rts
        
twocom  ldd     $40     ; get operand
        coma            ; take 1's complement
        comb
        addd    #1      ; add 1 to the result
        std     $42     ; save result
        rts

        org     $40
        fcb     0,$58,0,0

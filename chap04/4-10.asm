; 4-10. 16-bit ones complement

; Place the ones complement of the 16-bit number in memory locations
; $40 and $41 in memory locations $42 and $43. The most significant
; bytes are in locations $40 and $42.

        org     $4000
        setdp   0

        ldd     $40
        coma
        comb
        std     $42
        rts

        org     $40
        fdb     $67e2
        fdb     0

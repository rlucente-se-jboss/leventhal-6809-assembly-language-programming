; 4-8. 16-bit addition 

; Add the 16-bit number in memory locations $40 and $41 to the
; 16-bit number in memory locations $42 and $43. The most significant
; bytes are in memory locations $40 and $42. Store the result in
; memory locations $44 and $45, with the most significant byte in
; $44.

        org     $4000
        setdp   0

        ldd     $40     ; get first 16-bit number
        addd    $42     ; add second 16-bit number
        std     $44     ; store 16-bit result

        rts

        org     $40
        fdb     $672a
        fdb     $14f8
        fdb     0

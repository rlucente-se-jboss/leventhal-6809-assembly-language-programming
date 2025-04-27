; Problem 4-1. 16-bit data transfer

; Move the contents of memory location 0040 to memory location 0042
; and the contents of memory location 0041 to memory location 0043.

        org $4000
        setdp 0

start   ldd     $40     ; get the data (16-bits)
        std     $42     ; store the result
        rts

        org     $40
        fdb     $3eb7
        fdb     0

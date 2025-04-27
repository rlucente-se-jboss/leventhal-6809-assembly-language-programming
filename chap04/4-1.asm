; 4-1. 8-bit data transfer

; Move the contents of memory location $40 to memory location $41.

        org     $4000
        setdp   0

start   lda     $40     ; get data
        sta     $41     ; transfer to new location
        rts

        org     $40
        fcb     $6a
        fcb     $7f

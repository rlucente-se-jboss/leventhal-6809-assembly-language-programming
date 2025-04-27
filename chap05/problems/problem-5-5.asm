; Problem 5-5. count 1 bits

; Determine how many bits in memory location $40 are ones and place
; the result in memory location $41.

        org     $4000
        setdp   0

        clr     <result

        lda     <data
        ldb     #8

cntbit  asla
        bpl     next

        inc     <result

next    decb
        bne     cntbit

        rts

        org     $40

data    fcb     $3b
result  fcb     $00

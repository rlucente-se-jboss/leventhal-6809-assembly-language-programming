; Problem 4-3. shift left two bits

; Shift the contents of memory location $40 left two bits and place
; the result in memory location $41. Clear the two least significant
; bit positions.

        org $4000
        setdp 0

start   lda     $40     ; get the bits to shift
        asla            ; shift left two bits
        asla
        sta     $41
        rts

        org     $40
        fcb     $5d, 0

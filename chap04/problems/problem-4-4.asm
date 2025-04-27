; Problem 4-4. mask off least significant four bits

; Place the four most significant bits of memory location $40 in
; memory location $41. Clear the four least significant bits of memory
; location $41.

        org $4000
        setdp 0

start   lda     $40             ; get the data
        anda    #%11110000      ; clear the least significant bits
        sta     $41
        rts

        org     $40
        fcb     $c4, 0

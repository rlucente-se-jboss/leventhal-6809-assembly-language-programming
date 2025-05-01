; Problem 4-6. byte assembly

; Combine the four least significant bits of memory locations $40
; and $41 into a byte and store the result in memory location $42.
; Place the four least significant bits of memory location $40 in the
; four most significant bit positions of memory location $42; place
; the four least significant bits of memory location $41 in the four
; least significant bit positions of memory location $42.

        org $4000
        setdp 0

start   lda     $40             ; get lsb's of first
        anda    #%00001111      ; mask off msb's
        asla                    ; move lsb's to msb's
        asla
        asla
        asla
        sta     $42             ; save partial result

        lda     $41             ; get lsb's of second
        anda    #%00001111      ; mask off msb's
        ora     $42             ; combine nibbles
        sta     $42

        rts

        org     $40
        fcb     $6a, $b3, 0

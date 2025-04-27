; 4-4. mask off most significant four bits

; Place the least significant four bits of memory location 0040 in
; the least significant four bits of memory location $41. Clear the
; most significant four bits of memory location 0041.

        org     $4000
        setdp   0

start   lda     $40             ; get data
        anda    #%00001111      ; mask leftmost nibble
        sta     $41             ; store result
        rts

        org     $40
        fcb     $3d
        fcb     $00

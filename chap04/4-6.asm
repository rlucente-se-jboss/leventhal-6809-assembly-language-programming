; 4-6. byte disassembly

; Divide the contents of memory location $40 into two 4-bit sections
; (sometimes called "nibbles" or "nybbles") and place the sections
; in the low-order four bits of memory locations $41 and $42. Place
; the four most significant bits of $40 in $41 and the four least
; significant bits of $40 in $42. Clear the four most significant
; bits of both $41 and $42.

        org     $4000
        setdp   0

start   lda     $40             ; get data
        anda    #%00001111      ; mask off msb's
        sta     $42             ; store lsb's
        lda     $40             ; reload data
        lsra                    ; shift msb's to least
        lsra                    ;     significant positions
        lsra                    ;     and clear other
        lsra                    ;     positions
        sta     $41             ; store msb's

        lda     #$3f            ; reset from last time
        sta     $40
        clra
        clrb
        sta     $41
        sta     $42

        lda     $40             ; get data
        tfr     a,b             ; save copy in b
        anda    #%00001111      ; mask off msb's
        sta     $42             ; store lsb's
        lsrb                    ; shift msb's to least
        lsrb                    ;     significant positions
        lsrb                    ;     and clear other
        lsrb                    ;     positions
        stb     $41             ; store msb's

        rts

        org     $40
        fcb     $3f

; 8-4. binary division

; Divide the 16-bit unsigned number in memory locations $40 and $41
; (most significant bits in $40) by the 8-bit unsigned number in
; memory location $42. The numbers are normalized so that 1) the most
; signicant bits of both the dividend and the divisor are zero and
; 2) the number in memory location $42 is greater than the number in
; memory location $40, i.e., the quotient is an 8-bit number. Store
; the remainder in memory location $43 and the quotient in memory
; location $44.

                setdp   0
                org     $4000

                bsr     bindiv

                ldd     #$326d
                std     <dividend
                lda     #$47
                sta     <divisor
                clr     <remainder
                clr     <quotient

bindiv          lda     #8              ; count = 8
                sta     <remainder      ; remainder temporarily holding our bit counter
                ldd     <dividend       ; get dividend

divide          aslb                    ; shift dividend, quotient
                rola
                cmpa    <divisor        ; is trial subtraction successful?
                bcs     chkcnt
                suba    <divisor        ;   yes, subtract and set bit in quotient
                incb
chkcnt          dec     <remainder      ; keep going for all bits in the divisor
                bne     divide
                std     <remainder      ; store remainder, quotient

                rts

                org     $40
dividend        fdb     $0040   ; msb is zero
divisor         fcb     $08     ; msb is zero
remainder       fcb     $00
quotient        fcb     $00

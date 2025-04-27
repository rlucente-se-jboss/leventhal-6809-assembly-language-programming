; Problem 8-4. signed binary division

; Divide the 16-bit signed number in memory locations $40 and $41
; (most significant bits in $40) by the 8-bit signed number in memory
; location $42. The numbers are normalized so that the magnitude of
; memory location $42 is greater than the magnitude of memory location
; $40. Store the quotient (signed) in memory location $44 and the
; remainder (always positive) in memory location $43.

; Hint: Determine the sign of the result, perform an unsigned
; division, and finally adjust the quotient and remainder to the
; proper forms.

; Additional notes: The sign of the quotient is the xor of the signs
; of both the divisor and the dividend. The sign of the remainder
; matches the sign of the dividend. Getting an "always positive"
; remainder when the dividend is negative means subtracting one from
; the quotient and then subtracting the remainder (which we made
; positive for the divide) from the divisor.

                setdp   0
                org     $4000

                bsr     signeddiv       ; process first example

                ldd     #$ed93          ; set up second example
                std     <dividend
                lda     #$47
                sta     <divisor
                ldd     #0              ; clear remainder and quotient
                std     <remainder
                std     <dividendsign   ; clear signs for the dividend and quotient

signeddiv       clr     <dividendsign   ; dividend sign initially positive (e.g. 0)

                tst     <dividend       ; test if the dividend is negative
                bpl     testdivisor

                ldd     #0              ;     if negative, negate dividend
                subd    <dividend
                std     <dividend

                lda     #$ff            ;     and set dividend sign to negative (e.g. $ff)
                sta     <dividendsign
                                
testdivisor     clra                    ; a is divisor sign
                ldb     <divisor        ; test if the divisor is negative
                tstb
                bpl     getquotsign

                sex                     ; if negative, set divisor sign in A to negative (e.g. $ff)
                negb                    ;     and negate divisor
                stb     <divisor

getquotsign     eora    <dividendsign   ; sign of quotient is divisor sign (in A) xor'ed with dividend sign
                sta     <quotientsign   ; NB: remainder sign = dividend sign

unsigneddiv     lda     #8              ; count = 8
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

; at this point, A is the remainder and B is the quotient (which are both positive)

                tst     <quotientsign   ; if quotient was supposed to be negative
                bpl     adjremainder
                negb                    ;     make quotient negative

adjremainder    tsta                    ; if remainder is zero
                beq     done            ;     don't adjust

                tst     <dividendsign   ; if dividend was originally negative
                bpl     done
                nega                    ;     make remainder negative
                adda    <divisor        ;     add to divisor to adjust remainder
                decb                    ;     dec quotient since negative remainder now positive

done            std     remainder       ; store both remainder and quotient
                rts

                org     $40
dividend        fdb     $ffc0   ; msb is zero when positive
divisor         fcb     $08     ; msb is zero when positive
remainder       fcb     $00
quotient        fcb     $00
dividendsign    fcb     $00
quotientsign    fcb     $00

; 8-5b. dividing decimal numbers by 2

; You can divide a decimal number by 2 simply by shifting it right
; logically and then subtracting 3 from any digit that has a value
; of 8 or larger (since $10 BCD is 16). The following program divides
; a decimal number in memory location $40 by 2 and places the result
; in memory location $41.

; bcd   shift   desired
; 00    00      00
; 01    00      00
; 02    01      01
; 03    01      01
; 04    02      02
; 05    02      02
; 06    03      03
; 07    03      03
; 08    04      04
; 09    04      04
; 10    08      05      <-- must subtract 3 for correct value in this case
; 30    18      15      NB: most significant digit (msd) is correct since
; 37    1B      18          it's always in the range 0-9 anyway.

        org     $4000
        setdp   0

        bsr     divdec

        lda     #$30
        sta     <decimal
        clr     <result

        bsr     divdec

        lda     #$37
        sta     <decimal
        clr     <result

divdec  lda     <decimal        ; get decimal number
        lsra                    ; divide by 2 in binary
        tfr     a,b             ; move quotient to b for testing
        andb    #$0f            ; mask off msd
        cmpb    #8              ; is lsd 8 or more?
        blo     done
        suba    #3              ; yes, subtract 3 from lsd for decimal
done    sta     <result         ; store result
        rts

        org     $40
decimal fcb     $28
result  fcb     $00

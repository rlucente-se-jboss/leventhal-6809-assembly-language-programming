; 5-1b. sum of data

; Calculate the sum of a series of numbers. The length of the series
; is in memory location $41 and the series begins in memory location
; $42. Store the sum in memory location $40. Assume that the sum is
; an 8-bit number so that you can ignore carries.

        org     $4000
        setdp   0

        clra                    ; clear the sum
        ldb     <count          ; get number of elements
        ldy     #pointer        ; data to be counted
sumd    adda    ,y+             ; add next value
        decb                    ; decrement count
        bne     sumd            ; quit if zero
        sta     <sum            ; save result

        rts

        org     $40
sum     rmb     1
count   fcb     $03
pointer fcb     $28,$55,$26

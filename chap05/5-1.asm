; 5-1. sum of data

; Calculate the sum of a series of numbers. The length of the series
; is in memory location $41 and the series begins in memory location
; $42. Store the sum in memory location $40. Assume that the sum is
; an 8-bit number so that you can ignore carries.

        org     $4000
        setdp   0

ver1    clra                    ; clear the sum
        ldb     count           ; get number of elements
        ldx     #pointer        ; data to be counted
sumd1   adda    ,x+             ; add next value
        decb                    ; decrement count
        bne     sumd1           ; quit if zero
        sta     sum             ; save result

ver2    clra                    ; clear the sum
        clrb                    ; current element
        ldx     #pointer        ; data to be counted
sumd2   adda    b,x             ; add next value
        incb                    ; increment count
        cmpb    count           ; check if done
        bne     sumd2           ; continue if not
        sta     sum             ; save result
        rts

        org     $40
sum     rmb     1
count   fcb     $03
pointer fcb     $28,$55,$26

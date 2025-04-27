; Problem 5-1. checksum of data

; Calculate the checksum of a series of numbers. The length of the
; series is in memory location $41, and the series itself begins in
; memory location $42. Store the checksum in memory location $40. The
; checksum is formed by Exclusive-ORing all the numbers in the series
; together.

        org     $4000
        setdp   0

        ldx     #pointer        ; x points to data
        clra                    ; clear the checksum
        ldb     <count          ; get number of elements
        beq     done

loop    eora    ,x+             ; next element into checksum
        decb                    ; count = count - 1
        bne     loop            ; keep going if not zero

done    sta     <cksum          ; save current checksum
        rts

        org     $40
cksum   rmb     1
count   fcb     $03
pointer fcb     $28,$55,$26

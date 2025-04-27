; Problem 5-2. sum of 16-bit data

; Calculate the sum of an array of 16-bit numbers. The length of
; the array is in memory location $42 and the array itself begins in
; memory location $43. Store the sum in memory locations $40 and $41
; with the eight most significant bits in $40. Each 16-bit number
; occupies two bytes of memory, with the eight most significant bits
; first (in the lower address). Assume that the summation does not
; result in any carries (i.e., the sum is a 16-bit number).

        org     $4000
        setdp   0

        clra                    ; clear the result
        clrb
        
        tst     <length
        beq     done

        ldx     #array          ; point to the start of the data

addem   addd    ,x++            ; add and advance the pointer
        dec     <length         ; count = count - 1
        bne     addem

done    std     <result
        rts

        org     $40
result  rmb     2
length  fcb     $03
array   fdb     $28f1,$301a,$4b89

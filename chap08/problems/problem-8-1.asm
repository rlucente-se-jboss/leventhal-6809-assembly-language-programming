; Problem 8-1. multiple-precision binary subtraction

; Subtract one multi-byte binary number from another. The length
; of the numbers (in bytes) is in memory location $40, the numbers
; themselves start (least significant bits first) in memory locations
; $41 and $51 respectively, and the difference replaces the number
; starting in memory location $41. Subtract the number starting in
; $51 from the one starting in $41.

                org     $4000
                setdp   0

mpbinsub        ldx     #minuend
                ldy     #subtrahend

                ldb     <count
                andcc   #%11111110      ; clear the carry flag

subnext         lda     ,x              ; get next byte of minuend
                sbca    ,y+             ; subtract next byte of subtrahend
                sta     ,x+             ; overwrite minuend with result byte
                decb
                bne     subnext         ; continue until all bytes processed
                rts

                org     $40
count           fcb     $04
minuend         fcb     $c3,$a7,$5b,$2f

                org     $51
subtrahend      fcb     $b8,$35,$df,$14

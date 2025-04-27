; Problem 8-2. decimal subtraction

; Subtract one multi-byte decimal (BCD) number from another. The
; length of the numbers (in bytes) is in memory location $40, the
; numbers themselves start (least significant digits first) in memory
; locations $41 and $51 respectively, and the difference replaces the
; number starting in memory location $41. Subtract the number starting
; in $51 from the one starting in $41.

                org     $4000
                setdp   0

; HINT: Use the relationship that x - y = x + (99 - y) + ~borrow
;       for x and y as BCD digits

; minuend := minuend - subtrahend

decsub          ldx     #minuend        ; point to minuend bcd digits
                ldy     #subtrahend     ; point to subtrahend bcd digits
                ldb     <count
                orcc    #1              ; opposite of borrow so carry should be set
subnext         lda     #$99            ; 99 - y + carry
                adca    #0
                suba    ,y+
                adda    ,x              ; add x to that number
                daa                     ; adjust for decimal
                sta     ,x+             ; save result
                decb
                bne     subnext         ; continue until all bytes processed
                rts

                org     $40
count           fcb     $04
minuend         fcb     $85,$19,$70,$36

                org     $51
subtrahend      fcb     $59,$34,$66,$12

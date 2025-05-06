; Problem 10-5. decimal subtraction

; Subtract one multi-digit decimal (BCD) number from another. The
; length of the numbers (in bytes) is in Accumulator B and the starting
; addresses of the numbers are in Index Registers X and Y. Subtract
; the number with the starting address in Index Register Y from the
; one with the starting address in Index Register X. The starting
; address of the result is in the user Stack Pointer U. All the numbers
; begin with the least significant digits. The sign of the result is
; returned in Accumulator B - zero if the result is positive, $FF if
; it is negative.

                org     $4000
                setdp   0

                ldx     <minuendptr
                ldy     <subtraptr
                ldu     <diffptr
                ldb     <count
                jsr     decsub
                rts

* subroutine decsub
*
* purpose: Subtract one multi-byte decimal (BCD) number from another.
*   The length of the numbers (in bytes) is in accumulator B and the
*   starting addresses of the numbers are in index registers X and Y.
*   Subtract the number with the starting address in index register Y
*   from the one with the starting address in index register X. The
*   starting addres of the result in in the user stack pointer U. All
*   the numbers begin with the least significant digits. The sign of
*   the result is returned in accumulator B - zero if the result is
*   positive, $ff is it is negative.
*
* initial conditions: (X) is the start of the minuend, (Y) is the
*   start of the subtrahend, (U) is the start of the result, and (B)
*   is the number of bytes in each number.
*
* final conditions: (U) is the start of the result and (B) is $ff
*   if the result is negative and zero otherwise.
*
* registers affected: A, B, X, Y, FLAGS

                org     $20

; HINT: Use the relationship that x - y = x + (99 - y) + ~borrow
;       for x and y as BCD digits
;       result := minuend - subtrahend

decsub          orcc    #1              ; opposite of borrow so carry should be set
subnext         lda     #$99            ; 99 - y + carry
                adca    #0
                suba    ,y+
                adda    ,x+             ; add x to that number
                daa                     ; adjust for decimal
                sta     ,u+             ; save result
                decb
                bne     subnext         ; continue until all bytes processed
                bcs     done            ; is result negative?
                comb                    ;   yes, b = $ff
done            rts

                org     $41
count           fcb     $04
minuendptr      fdb     minuend
subtraptr       fdb     subtrahend
diffptr         fdb     difference

minuend         fcb     $85,$19,$70,$36
subtrahend      fcb     $59,$34,$66,$12
difference      fcb     $00,$00,$00,$00

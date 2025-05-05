; 10-5. multiple-precision addition

; Add two multi-byte binary numbers. The length of the numbers (in
; bytes) is in Accumulator B, the starting addresses of the numbers
; are in Index Registers X and Y, and the starting address of the
; result is in the User Stack Pointer U. All the numbers begin with
; the least significant bits.

                org     $4000
                setdp   0

                ldx     #pointer1       ; get starting address of first number
                ldy     #pointer2       ; get starting address of second number
                ldu     #result         ; get starting address of sum
                ldb     <count          ; get length of numbers (in bytes)
                jsr     mpadd           ; perform multiple-precision addition
                rts

* subroutine mpadd
*
* purpose: mpadd adds two multi-byte binary numbers
* 
* initial conditions: starting addresses of numbers (lsb's) in index
* registers X and Y, starting address of sum in user stack pointer
* U, length of numbers (in bytes) in accumulator B
*
* registers affected: A,B,X,Y,U,FLAGS
*
* sample case:
*   initial conditions: (X) = $48, (Y) = $4c, (U) = $50, (B) = $02,
*     ($48) = $c3, ($49) = $a7, ($4c) = $b8, ($4d) = $35
*   result: ($50) = $7b, ($51) = $dd

                org     $20
mpadd           andcc   #%11111110      ; clear carry to start
adbyte          lda     ,x+             ; get byte from first number
                adca    ,y+             ; add byte from second number
                sta     ,u+             ; store result
                decb                    ; all bytes added?
                bne     adbyte          ;   no, continue
                rts

                org     $40
count           fcb     $04

                org     $48
pointer1        fcb     $c3,$a7,$5b,$2f
pointer2        fcb     $b8,$35,$df,$14
result          fcb     $00,$00,$00,$00

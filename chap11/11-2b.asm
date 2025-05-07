; 11-2b. multiple-precision addition

; Add two multi-byte binary numbers. The starting addresses of the
; numbers and the result, as well as the length of the numbers in
; bytes, are on the Hardware Stack. The starting address of the result
; ends up at the top of the Hardware Stack. No registers or flags are
; affected.

                org     $4000
                setdp   0

                ldu     #result         ; get starting address of result
                ldx     #operand1       ; get starting addresses of operands
                ldy     #operand2
                lda     #4              ; get length of strings
                pshs    u,y,x,a         ; save parameters in hardware stack
                jsr     mpadd           ; perform multiple-precision addition
                leas    5,s             ; remove parameters from stack
                puls    x               ; get address of result
                stx     <resultptr      ; save address of result
                rts

* subroutine mpadd
*
* purpose: mpadd adds two multi-byte binary numbers
*
* initial conditions: length of strings (in bytes) on top of stack,
*   followed by starting addresses of lsb's of operands and starting
*   address of lsb's of sum
*
* registers affected: none
*
* sample case:
*   initial conditions: length = $02, operand addresses = $48 and
*     $4c, address of sum = $50
*     ($48) = $c3, ($49) = $a7, ($4c) = $b8, ($4d) = $35
*   result: ($50) = $7b, ($51) = $dd ($a7c3 + $35b8 = $dd7b)
*
* typical call:
*       ldx     #oper1          ; starting address (lsb's) of operand 1
*       ldy     #oper2          ; starting address (lsb's) of operand 2
*       ldu     #sum            ; starting address (lsb's) of sum
*       lda     #length         ; length of strings (in bytes)
*       pshs    u,y,x,a         ; save parameters in hardware stack
*       jsr     mpadd           ; perform multiple-precision addition

                org     $20
mpadd           pshs    u,y,x,b,a,cc    ; save registers
                leau    11,s            ; access parameter list in stack
                pulu    x,y,b           ; get length, addresses of operands
                ldu     ,u              ; get starting address of result
                andcc   #%11111110      ; clear carry to start

adbyte          lda     ,x+             ; get byte from first number
                adca    ,y+             ; add byte from second number
                sta     ,u+             ; store result
                decb                    ; all bytes added?
                bne     adbyte          ;   no, continue
                puls    pc,u,y,x,b,a,cc ; restore registers and return

                org     $40
resultptr       fdb     $0000

                org     $48
operand1        fcb     $c3,$a7,$5b,$2f
operand2        fcb     $b8,$35,$df,$14
result          fcb     $00,$00,$00,$00

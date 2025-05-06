; 11-2a. multiple-precision addition

; Add two multi-byte binary numbers. The starting addresses of the
; numbers and the result, as well as the length of the numbers in
; bytes, folow the subroutine call. No registers or flags are affected.

                org     $4000
                setdp   0

                jsr     mpadd                   ; perform multiple-precision addition
                fcb     $04                     ; length of numbers (in bytes)
                fdb     firstnum                ; address of lsb's of 1st number
                fdb     secondnum               ; addresss of lsb's of 2nd number
                fdb     result                  ; address of lsb's of sum
                rts

* subroutine mpadd
*
* purpose: mpadd adds two multi-byte binary numbers
*
* initial conditions: subroutine call is followed by length of
*   strings (in bytes), starting address of lsb's of operands, and
*   starting address of lsb's of sum
*
* registers affected: none
*
* sample case:
*   initial conditions: length = $02, operand addresses = $48 and
*     $4c, address of sum = $50, ($48) = $c3, ($49) = $a7, ($4c) = $b8,
*     ($4d) = $35
*   result: ($50) = $7b, ($51) = $dd ($a7c3 + $35b8 = $dd7b)
*
* typical call:
*               jsr     mpadd
*               fcb     lngth           ; length of numbers (in bytes)
*               fdb     oper1           ; starting address (lsb's) of operand 1
*               fdb     oper2           ; starting address (lsb's) of operand 2
*               fdb     sum             ; starting address (lsb's) of sum

                org     $20
mpadd           pshs    x,y,u,a,b,cc            ; save all registers
                ldu     9,s                     ; access parameter list
                pulu    x,y,b                   ; get length, addresses of operands
                ldu     ,u                      ; get address of sum
                andcc   #%11111110              ; clear carry to start
adbyte          lda     ,x+                     ; get byte from first number
                adca    ,y+                     ; add byte from second number
                sta     ,u+                     ; store result
                decb                            ; all bytes added?
                bne     adbyte                  ;   no, continue
                ldu     9,s                     ; adjust return address past argument list
                leau    7,u
                stu     9,s
                puls    pc,u,y,x,b,a,cc         ; restore registers and return

                org     $48
firstnum        fcb     $c3,$a7,$5b,$2f
secondnum       fcb     $b8,$35,$df,$14
result          fcb     $00,$00,$00,$00

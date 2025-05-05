; Problem 10-2. length of a teletypewriter message

; Determine the length of an ASCII-coded teletypewriter message.
; The starting address of the string of characters in which the message
; is embedded is in Index Register X. The message itself starts with
; an ASCII STX character ($02) and ends with ASCII ETX ($03). Place
; the length of the message (the number of characters between the STX
; and the ETX) in Accumulator B.

                org     $4000
                setdp   0

                ldx     #pointer
                jsr     msglen
                rts

                org     $44
pointer         fcb     $49,$02,'G','O',$03

* subroutine msglen
*
* purpose: determines the number of characters between an ASCII STX
* ($02) and an ASCII ETX ($03).
*
* initial conditions: (X) is first character in message
*
* final conditions: (B) is number of characters
*
* registers affected: A, B, X, FLAGS

ASC_STX         equ     $02
ASC_ETX         equ     $03

msglen          lda     #ASC_STX        ; looking for STX
                bsr     findmarker

                lda     #ASC_ETX        ; looking for ETX
                ldb     #$ff            ; count starts at -1

findmarker      incb                    ; bump counter
                cmpa    ,x+             ; find message marker
                bne     findmarker
                rts

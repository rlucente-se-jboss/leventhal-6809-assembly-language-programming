; 10-2. length of a string of characters

; Determine the length of a string of ASCII characters. The starting
; address of the string is in Index Register X. The end of the string
; is marked by a carriage return character (CR, $0d). Place the length
; of the string (excluding the carriage return) in Accumulator B.

                org     $4000
                setdp   0

                ldx     <pointer        ; get starting address of string
                jsr     stlen           ; determine length of string
                stb     <count          ; store string length

                lda     #$0d            ; create zero length string
                ldx     <pointer        ; get starting address of string
                sta     ,x              ; make zero length
                jsr     stlen           ; determine length of string
                stb     <count          ; store string length
                rts

* subroutine stlen
*
* purpose: stlen determines the length of a string (number of
*          characters before a carriage return)
*
* initial conditions: starting address of string in index register X
* 
* final conditions: number of characters in B
*
* registers affected: a,b,x,flags
*
* sample case
*    initial conditions: (X) = $42
*        ($42) = $4d, ($43) = $41, ($44) = $4e, ($45) = $0d
*    final conditions: (B) = $03

                org     $20
stlen           ldb     #$ff            ; string length = -1
                lda     #$0d            ; get ascii carriage return to compare
chkcr           incb                    ; add 1 to string length
                cmpa    ,x+             ; is next character a carriage return?
                bne     chkcr           ;    no, keep looking
                rts

                org     $40
pointer         fdb     $0043
count           fcb     $00

                fcc     'RATHER'        ; $43
                fcb     $0d

; 10-4. pattern match

; Compare two strings of ASCII characters to see if they are the
; same. The length of the strings is in Accumulator B. The starting
; address of one string is in Index Register X and the starting address
; of the other string is in Index Register Y. If the two strings
; match, clear Accumulator B; otherwise, set Accumulator B to $FF.

                org     $4000
                setdp   0

                ldx     #pointer1       ; get starting address of string 1
                ldy     #pointer2       ; get starting address of string 2
                ldb     <count          ; get length of strings
                jsr     pmtch           ; compare strings
                stb     <result         ; save match indicator
                
                ldx     #pointer1       ; get starting address of string 1
                lda     #'R'            ; set up second example
                sta     ,x
                ldy     #pointer2       ; get starting address of string 2
                ldb     <count          ; get length of strings
                jsr     pmtch           ; compare strings
                stb     <result         ; save match indicator
                rts

* subroutine pmtch
*
* purpose: pmtch determinss if two strings are identical
*
* initial conditions: starting addresses of strings in index registers
*   X and Y, length of strings (in bytes) in accumulator B
*
* final conditions: zero in accumulator B if strings match, $ff in
*   accumulator B otherwise
*
* registers affected: A,B,X,Y,FLAGS
*
* sample case:
*   initial conditions: (X) = $46, (Y) = $50, (B) = $02
*     ($46) = $36, ($47) = $39
*     ($50) = $36, ($51) = $39
*   result: (B) = $00 since the strings are identical

                org     $20
pmtch           lda     ,x+             ; get a character from string 1
                cmpa    ,y+             ; is there a match with string 2
                bne     nomch           ;   no, done
                decb                    ; all characters checked
                bne     pmtch           ;   no, continue
                rts                     ;   yes, return with indicator = $00
nomch           ldb     #$ff            ; no match, indicator = $ff
                rts

                org     $40
result          fcb     $00
count           fcb     $03
                rmb     4
pointer1        fcc     'CAT'

                org     $50
pointer2        fcc     'CAT'

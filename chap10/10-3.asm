; 10-3. maximum value

; Find the largest element in an array of unsigned binary numbers.
; The length of the array (number of bytes) is in Accumulator B and
; the starting address of the array is in Index Register X. The maximum
; value is returned in Accumulator A.

                org     $4000
                setdp   0

                ldx     #pointer        ; get starting address of array
                ldb     <count          ; get length of array
                jsr     maxm            ; find maximum value
                sta     <maximum        ; save maximum value in memory
                rts

* subroutine maxm
*
* purpose: maxm determines the maximum value in an array of unsigned
*          binary numbers
*
* initial conditions: starting address of array in index register
*              X, length of array (number of bytes) in accumulator B
* 
* final conditions: maximum value in accumulator A
*
* registers affected: a,b,x,flags
*
* sample case
*    initial conditions: (X) = $43, (B) = $03,
*        ($43) = $35, ($44) = $46, ($45) = $0d
*    result: (A) = $46

                org     $20
maxm            clra                    ; maximum=0 (minimum possible value)
chke            cmpa    ,x+             ; is current entry greater than max?
                bcc     nochg
                lda     -1,x            ;    yes, replace max with current entry
nochg           decb
                bne     chke
                rts

                org     $40
count           fcb     $05
maximum         fcb     $00
                fcb     $00             ; unused
pointer         fcb     $67,$79,$15,$e3,$72

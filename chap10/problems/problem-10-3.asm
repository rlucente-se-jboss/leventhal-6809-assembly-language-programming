; Problem 10-3. minimum value

; Find the smallest element in an array of 8-bit unsigned binary
; numbers. The length of the array (number of bytes) is in Accumulator
; B and the starting address of the array is in Index Register X. The
; minimum value is returned in Accumulator A.

                org     $4000
                setdp   0

                ldb     <count
                ldx     <array
                jsr     minval
                rts

                org     $40
count           fcb     $05
array           fdb     pointer
pointer         fcb     $67,$79,$15,$e3,$73

* subroutine minval
*
* purpose: finds the smallest element in an array of 8-bit unsigned
*   binary numbers. Accumulator B has the length of the array and the
*  address of the array is in index register X. Accumulator A will
*  contain the minimum value.
*
* initial conditions: (X) is first number in the array, (B) is the
*   length of the array
*
* final conditions: (A) is the minimum value
*
* registers affected: A, B, X, FLAGS

                org     $20
minval          lda     #$ff            ; set minimum value to unsigned max
chkval          cmpa    ,x+             ; is value smaller?
                bls     nextval         ;   no, keep going
                lda     -1,x            ;   yes, get new minimum value
nextval         decb                    ; are we done?
                bne     chkval          ;   no, keep going
                rts

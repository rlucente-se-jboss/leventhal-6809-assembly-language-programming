; Problem 10-1. convert ascii to hexadecimal

; Convert the contents of Accumulator A from the ASCII representation
; of a hexadecimal digit to the actual digit. Place the result in
; Accumulator A.

                org     $4000
                setdp   0

                lda     #'C             ; load character 'C'
                bsr     aschex
                lda     #'6             ; load character 'C'
                bsr     aschex
                rts

* subroutine aschex
*
* purpose: aschex converts the contents of accumulator A from an
*    ascii digit to the actual digit in accumulator A
*
* initial conditions: ascii digit in A
*
* final conditions: actual digit in A
*
* registers affected: A, flags
*
* sample case
*    initial conditions: 'C' in accumulator A
*    final conditions: $0c in accumulator A

ASC_0           equ     '0'
ASC_9           equ     '9'
ASC_A           equ     'A'

aschex          suba    #ASC_0          ; convert characters 0 to 9
                cmpa    #9              ; is it > 9 ?
                bls     done            ;    no, we're done
                suba    #ASC_A-ASC_9-1  ;    yes, convert
done            rts

; 10-1. converting hexadecimal to ascii

; Convert the contents of Accumulator A from a hexadecimal digit
; to an ASCIl character. Assume that the original contents of Accumulator
; A are a valid hexadecimal digit.

                org     $4000
                setdp   0

                lda     <hexdata        ; get hexadecimal data
                jsr     asdec           ; convert data to ascii
                sta     <ascchar        ; store result
                rts

                org     $20

* subroutine asdec
*
* purpose: asdec converts a hexadecimal digit in accumulator A to
*   an ascii digit in accumulator A
*
* initial conditions: hexadecimal digit in A
*
* final conditions: ascii character in A
*
* registers affected: A, flags
*
* sample case
*    initial conditions: 6 in accumulator A
*    final conditions: ASCII 6 (hex 36) in accumulator A

ASC_A           equ     'A'
ASC_0           equ     '0'
ASC_9           equ     '9'

asdec           cmpa    #9              ; is data a decimal digit
                bls     ascz
                adda    #ASC_A-ASC_9-1  ;     no, add extra offset for letters
ascz            adda    #ASC_0          ; convert data to ascii by adding zero
                rts

                org     $40
hexdata         fcb     $0c
ascchar         fcb     $00

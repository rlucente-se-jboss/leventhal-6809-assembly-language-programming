; Problem 7-1. ascii to hexadecimal

; Convert the contents of memory location $40 to a hexadecimal digit
; and store the result in memory location $41. Assume that memory
; location $40 contains the ASCII representation of a hexadecimal
; digit (7 bits with MSB 0).

ASCII_0 equ     '0'
ASCII_9 equ     '9'
ASCII_A equ     'A'

        org     $4000
        setdp   0

aschex  lda     data
        suba    #ASCII_0
        cmpa    #9
        bls     done
        suba    #ASCII_A-ASCII_9-1
done    sta     result
        rts

        org     $40
data    fcc     'C'
result  fcb     $00

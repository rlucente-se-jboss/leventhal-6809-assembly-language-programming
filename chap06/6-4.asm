; 6-4. add even parity to ascii characters

; Add even parity to a string of 7-bit ASCII characters. The length
; of the string is in memory location $40 and the string itself begins
; in memory location $41. Place even parity in the most significant
; bit of each character by setting the most significant bit to l if
; that makes the total number of 1 bits in the byte an even number.

MSB     equ     %10000000

        org     $4000
        setdp   0

        ldx     #pointer        ; point to start of data block

gtbyte  lda     ,x+             ; get a byte of data
        clrb                    ; bit count = zero initially

chbit   asla                    ; shift a data bit to carry
        adcb    #0              ; if bit is 1, increment bit count
        tsta                    ; keep counting until data becomes zero
        bne     chbit

        lsrb                    ; did data have even number of '1' bits?
        bcc     nexte
        lda     -1,x            ; no, set even parity bit in data
        ora     #MSB
        sta     -1,x

nexte   dec     <count
        bne     gtbyte
        rts

        org     $40
count   fcb     6
pointer fcc     '123456'

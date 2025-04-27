; 7-4. bcd to binary

; Convert two BCD digits in memory locations $40 and $41 to a binary
; number in memory location $42. The most significant BCD digit is
; in memory location $40.

        org     $4000
        setdp   0

ascdec  lda     bcd1            ; get most significant digit
        ldb     #10             ; move to 10's column
        mul
        addb    bcd2            ; add lower digit
        stb     result
        
        rts

        org     $40
bcd1    fcb     2
bcd2    fcb     9
result  fcb     0

; Problem 7-4. binary to bcd

; Convert the contents of memory location $40 to two bcd digits in
; memory locations $41 and $42 (most significant digit in $41). The
; number in memory location $40 is unsigned and less than 100.

        setdp   0
        org     $4000

start   bsr     binbcd

        clr     bcd1
        clr     bcd2
        lda     #$47
        sta     data

binbcd:
        lda     data
        adda    #10
        ldb     #$ff
div10:
        incb
        suba    #10
        cmpa    #10
        bhs     div10
done:
        stb     bcd1
        sta     bcd2
        rts

        org     $40
data    fcb     $1d
bcd1    fcb     0
bcd2    fcb     0

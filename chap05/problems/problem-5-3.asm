; Problem 5-3. number of zero, positive, and negative numbers

; Determine the number of zero, positive (most significant bit = 0
; but entire number not zero), and negative (most significant bit =
; 1) elements in a block. The length of the block is in memory location
; $43, and the block itself starts in memory location $44. Place the
; number of negative elements in memory location $40, the number of
; zero elements in memory location $41, and the number of positive
; elements in memory location $42.

        org     $4000
        setdp   0

        clra
        sta     <negcnt
        sta     <zrocnt
        sta     <poscnt

        ldx     #block
        ldb     <length
        beq     done

count   lda     ,x+
        beq     inczro
        bmi     incneg

        inc     <poscnt
        bra     loop

inczro  inc     <zrocnt
        bra     loop

incneg  inc     <negcnt

loop    decb
        bne     count

done    rts

        org     $40

negcnt  rmb     1
zrocnt  rmb     1
poscnt  rmb     1

length  fcb     $06
block   fcb     $68,$f2,$87,$00,$59,$2a

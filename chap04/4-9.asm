; 4-9. table of squares

; Calculate the square of the contents of memory location $41 from
; a table and place the square in memory location $42. Assume that
; memory location $41 contains a number between 0 and 7 inclusive;
; that is, 0 ≤ ($41) ≤ 7. The table occupies memory locations $50
; through $57.

        org     $4000
        setdp   0

        bsr     square

        lda     #$06
        sta     $41
        clr     $42

square  ldb     $41     ; get data
        ldx     #$50    ; get base address
        lda     b,x     ; lookup square of data
        sta     $42     ; store square
        rts

        org     $41
        fcb     $03
        fcb     $00

        org     $50
sqtab   fcb     0,1,4,9,16,25,36,49

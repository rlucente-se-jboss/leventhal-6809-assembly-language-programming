; Problem 4-9. sum of squares

; Calculate the squares of the contents of memory locations $40 and
; $41 and add them together. Place the result in memory location $42.
; Assume that memory locations $40 and $41 both contain numbers between
; 0 and 7 inclusive; that is, 0 ≤ ($40) ≤ 7 and 0 ≤ ($41) < 7. Use
; the table of squares from the example entitled Table of Squares.

        org $4000
        setdp 0

        ldx     #sqtab  ; x points to table of squares
        ldb     $40     ; get first operand as index where 0 <= b <= 7
        lda     b,x     ; get the square via lookup

        ldb     $41     ; get second operand as index where 0 <= b <= 7
        adda    b,x     ; add the square of 2nd to the square of 1st

        sta     $42
        rts

        org     $40
        fcb     3,6,0

        org     $50
sqtab   fcb     0,1,4,9,16,25,36,49

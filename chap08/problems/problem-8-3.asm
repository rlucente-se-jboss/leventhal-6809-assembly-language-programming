; Problem 8-3. 16-bit by 16-bit binary multiplication

; Multiply the 16-bit unsigned number in memory locations $40 and
; $41 (MSB's in $40) by the 16-bit unsigned number in memory locations
; $42 and $43 (MSB's in $42). Store the result in memory locations
; $44 through $47, with the most significant bits in memory location
; $44.

                org     $4000
                setdp   0

                bsr     mult16x16

                ldd     #$2710
                std     <mul_a
                ldd     #$7530
                std     <mul_c

                ldd     #0
                std     <product_1
                std     <product_3

; Illustrates how the partial products align
;
;       a b
;     x c d
;     -----
;            product
;         1   2   3
;       +---+---+---+---+
;       |       | (d*b) | (1)
;       +---+---+---+---+
;       |   | (d*a) |   | (2)
;       +---+---+---+---+
;       |   | (c*b) |   | (3)
;       +---+---+---+---+
;       | (c*a) |   |   | (4)
;       +---+---+---+---+

mult16x16       lda     <mul_d          ; calculate partial product (1)
                ldb     <mul_b
                mul
                std     <product_3      ; store it

                lda     <mul_d          ; calculate partial product (2)
                ldb     <mul_a
                mul
                addb    <product_3      ; add msb of (1) to lsb of (2)
                adca    #0              ; add any carry to msb of (2)
                std     <product_2      ; update partial product

                lda     <mul_c          ; calculate partial product (3)
                ldb     <mul_b
                mul
                addb    <product_3      ; add lsb of (3) to lsb of (2)
                adca    <product_2      ; add msb of (3) to msb of (2) with carry
                std     <product_2      ; update partial product

                lda     <mul_c          ; calculate partial product (4)
                ldb     <mul_a
                mul
                addb    <product_2      ; add msb of (3) to lsb of (4)
                adca    #0              ; add any carry to msb of (4)
                std     <product_1      ; update partial product

                rts

                org     $40
mul_a           fcb     $00     ; multiplicand
mul_b           fcb     $03

mul_c           fcb     $00     ; multiplier
mul_d           fcb     $05

product_1       fcb     $00     ; result
product_2       fcb     $00
product_3       fdb     $0000

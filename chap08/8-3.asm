; 8-3. 8-bit by 16-bit binary multiplication

; Multiply the 8-bit unsigned number in memory location $40 by the
; 16-bit unsigned number in memory locations $41 and $42 (MSB's in
; $41). Place the product in memory locations $43, $44, and $45, with
; the MSB's in $43 and the LSB's in $45.

                setdp   0
                org     $4000
        
                lda     <multiplier     ; get multiplier
                ldb     <multiplicand+1 ; get lsb's of multiplicand
                mul                     ; multiply lsb's
                std     <product+1      ; save partial product
                lda     <multiplier     ; get multiplier
                ldb     <multiplicand   ; get msb's of multiplicand
                mul                     ; multiple msb's
                addb    <product+1      ; add lsb's to msb's of previous partial product
                adca    #0              ; add carry to msb's
                std     <product        ; save sum of partial products
                rts

                org     $40
multiplier      fcb     $03     ; 8-bit multiplier
multiplicand    fdb     $0005   ; 16-bit multiplicand
product         fcb     0,0,0   

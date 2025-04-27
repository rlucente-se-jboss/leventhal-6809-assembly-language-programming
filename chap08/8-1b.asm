; 8-1b. multiple-precision binary addition

; Add two multi-byte binary numbers. The length of the numbers (in
; bytes) is in memory location $40, the numbers themselves start
; (least significant bits first) in memory locations $41 and $51
; respectively, and the sum replaces the number starting in memory
; location $41.

                org     $4000
                setdp   0

                ldb     <count          ; count=length of bytes to add
                ldx     #pointer1       ; point to lsb's of first number
                ldy     #pointer2       ; point to lsb's of second number
                ldu     #result         ; point to lsb's of result

                andcc   #%11111110      ; clear carry to start

adbyte          lda     ,x+             ; get byte from first number
                adca    ,y+             ; add byte from second number
                sta     ,u+             ; store result in first number
                decb
                bne     adbyte          ; continue until all bytes added

                rts

                org     $40
count           fcb     $04
pointer1        fcb     $c3,$a7,$5b,$2f

                org     $51
pointer2        fcb     $b8,$35,$df,$14

                org     $61
result          rmb     4

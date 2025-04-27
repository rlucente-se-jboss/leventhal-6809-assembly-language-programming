; 8-2. decimal addition

; Add two multi-byte decimal (BCD) numbers. The length of the numbers
; (in bytes) is in memory location $40, the numbers themselves start
; (least significant digits first) in memory locations $41 and $51
; respectively, and the sum replaces the number starting in memory
; location $41.

                org     $4000
                setdp   0

                ldb     <count          ; count=length of numbers in bytes
                ldx     #pointer1       ; point to lsb's of first number
                ldy     #pointer2       ; point to lsb's of second number
                andcc   #%11111110      ; clear carry to start

addigs          lda     ,x              ; get two digits of first number
                adca    ,y+             ; add two digits of second number
                daa                     ; decimal correction
                sta     ,x+             ; store result in first number
                decb
                bne     addigs          ; continue until all digits added
        
                rts
        
                org     $40
count           fcb     $04
pointer1        fcb     $85,$19,$70,$36
        
                org     $51
pointer2        fcb     $59,$34,$66,$12

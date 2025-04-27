; Problem 4-2. 8-bit subtraction

; Subtract the contents of memory location $41 from the contents
; of memory location $40. Place the result in memory location $42.

        org $4000
        setdp 0

start   lda     $40     ; get the first operand
        suba    $41     ; subtract the second operand
        sta     $42     ; store the result
        rts

        org     $40
        fcb     $77,$39,0

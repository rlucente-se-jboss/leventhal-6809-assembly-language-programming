; 4-3. shift left 1 bit

; Shift the contents of memory location $40 left one bit and place
; the result in memory location $41. Clear bit position 0.

        org     $4000
        setdp   0

start   ldb     $40     ; get data
        aslb            ; shift left
        stb     $41     ; store result

        clr     $41

        ldb     $40     ; get data
        stb     $41     ; store operand
        asl     $41     ; shift left (in memory)

        rts

        org     $40
        fcb     $6f
        fcb     $00

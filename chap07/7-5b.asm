; 7-5b. binary number to ascii string

; Convert the 8-bit binary number in memory location $41 to eight
; ASCII characters (each either ASCII 0 or ASCII 1) in memory locations
; $42 through $49. (Place the most significant bit in location $42).
; This version is more efficient.

        org     $4000
        setdp   0

binasc  lda     data            ; get data to convert to binary
        ldx     #result         ; x points to buffer to store characters

        pragma  cc
conv    clrb
        asla                    ; put current msb into carry
        adcb    #'0             ; adjust to ASCII '1' if necessary
        stb     ,x+
        cmpx    #endres
        bne     conv
        
        pragma  cc
        rts

        org     $40
data    fcb     $d2
result  fcc     'XXXXXXXX'
endres  rmb     0

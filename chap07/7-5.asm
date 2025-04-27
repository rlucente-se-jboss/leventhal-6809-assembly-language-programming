; 7-5. binary number to ascii string

; Convert the 8-bit binary number in memory location $41 to eight
; ASCII characters (each either ASCII 0 or ASCII 1) in memory locations
; $42 through $49. (Place the most significant bit in location $42).

        org     $4000
        setdp   0

binasc  ldb     #'0             ; get ascii zero to store in string
        lda     data            ; get data
        ldx     #result         ; point to start of ascii string

        pragma  cc
conv    stb     ,x+             ; store ascii zero in string
        lsla                    ; is bit actually 1
        bcc     count
        inc     -1,x            ;     yes, make string element into ascii one
count   cmpx    #endres         ; check for end of conversion
        bne     conv
        
        pragma  cc
        rts

        org     $40
data    fcb     $d2
result  fcc     'XXXXXXXX'
endres  rmb     0

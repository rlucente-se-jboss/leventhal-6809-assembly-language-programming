; 7-3b. ascii to hexadecimal

; Convert the contents of memory location $40 from an ASCII character
; to a hexadecimal digit and store the result in memory location $41.
; If the contents of memory location $40 are not the ASCII representation
; of a hexadecimal digit, set the contents of memory location $41 to
; $FF.

        org     $4000
        setdp   0

ascdec  ldb     #$ff            ; get error marker
        lda     data            ; get data
        suba    #'0             ; is data below ascii zero?
        blo     done            ;    yes, not a digit
        cmpa    #9              ; is data above ascii nine?
        bls     digit           ;    yes, maybe hexadecimal
        suba    #$11            ; adjust to range 'A' and above
        cmpa    #5              ; is data above ascii 'F'?
        bhi     done            ;    yes, not a digit
        adda    #10             ; restore value A - F
digit   tfr     a,b             ; save valid digit
done    stb     result          ; save digit or error marker
        rts

        org     $40
data    fcb     '7'
result  fcb     0

; 30 = 0 00
; 31 = 1 01
; 32 = 2 02
; 33 = 3 03
; 34 = 4 04
; 35 = 5 05
; 36 = 6 06
; 37 = 7 07
; 38 = 8 08
; 39 = 9 09
; 3a = X 0a
; 3b = X 0b
; 3c = X 0c
; 3d = X 0d
; 3e = X 0e
; 3f = X 0f
; 40 = X 10
; 41 = A 11 00  0a
; 42 = B 12 01  0b
; 43 = C 13 02  0c
; 44 = D 14 03  0d
; 45 = E 15 04  0e
; 46 = F 16 05  0f

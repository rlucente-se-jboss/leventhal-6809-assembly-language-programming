; 7-3. ascii to decimal

; Convert the contents of memory location $40 from an ASCII character
; to a decimal digit and store the result in memory location $41. If
; the contents of memory location $40 are not the ASCII representation
; of a decimal digit, set the contents of memory location $41 to $FF.

        org     $4000
        setdp   0

ascdec  ldb     #$ff            ; get error marker
        lda     data            ; get data
        suba    #'0             ; is data below ascii zero?
        blo     done            ;    yes, not a digit
        cmpa    #9              ; is data above ascii nine?
        bhi     done            ;    yes, not a digit
        tfr     a,b             ; save valid digit
done    stb     result          ; save digit or error marker
        rts

        org     $40
data    fcb     '7'
result  fcb     0

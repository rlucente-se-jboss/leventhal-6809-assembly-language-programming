; Problem 6-2. find last non-blank character

; Search a string of ASCII characters for the last non-blank
; character. The string starts in memory location $42 and ends with
; a carriage return character ($0D). Place the address of the last
; non-blank character in memory locations $40 and $41 (most significant
; bits in $40).

CR      equ     $0d
SPACE   equ     $20

        bsr     fndnonb

        ldd     #0
        std     <result

        ldx     #data1
nxchar  lda     ,x+
        sta     data-data1-1,x
        cmpx    #dend
        bne     nxchar

fndnonb ldx     #data
        ldu     #0
        lda     #SPACE
        ldb     #CR

getchr  cmpb    ,x              ; if CR, then we're done
        beq     done

        cmpa    ,x+             ; if SPACE, keep looking
        beq     getchr

        leau    -1,x            ; save address of non-blank
        bra     getchr

done    stu     <result
        rts

        org     $40
result  rmb     2
data    fcc     '7'
        fcb     CR

        org     $50
data1   fcc     'A HAT  '
        fcb     CR
dend    rmb     0

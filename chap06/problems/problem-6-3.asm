; Problem 6-3. truncate decimal string to integer form

; Edit a string of ASCII decimal characters by replacing all digits
; to the right of the decimal point with ASCII blanks ($20). The
; string starts in memory location $41 and is assumed to consist
; entirely of ASCII-coded decimal digits and a possible decimal point
; ($2E). The length of the string is in memory location $40. If no
; decimal point appears in the string, assume that the decimal point
; is implicitly at the far right.

DECPT   equ     '.
SPACE   equ     $20

        bsr     repdec

        lda     #3
        sta     <length

        ldx     #data1
nxchar  lda     ,x+
        sta     data-data1-1,x
        cmpx    #dend
        bne     nxchar

repdec  lda     #DECPT
        ldx     #data
        ldb     <length

fnddec  decb
        beq     done
        cmpa    ,x+
        bne     fnddec

subspc  lda     #SPACE

nxtspc  sta     ,x+
        decb
        bne     nxtspc

done    rts

        org     $40
length  fcb     $04
data    fcc     '7.81'
        fcb     0,0,0,0,0,0,0,0,0,0,0,0,0,0

        org     $50
data1   fcc     '671'
        fcb     0,0,0,0,0,0,0,0,0,0,0,0,0,0
dend    rmb     0

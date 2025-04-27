; Problem 6-5. string comparison

; Compare two strings of ASCIl characters to see which is larger
; (that is, which follows the other in alphabetical ordering). The
; length of the strings is in memory location $41; one string starts
; in memory location $42 and the other in memory location $52. If the
; string starting in memory location $42 is greater than or equal to
; the other string, clear memory location $40; otherwise, set memory
; location $40 to all ones ($FF).

        org     $4000
        setdp   0

        bsr     strcmp

        ldx     #string3
        ldb     #3
        stb     <length
chstr1  lda     ,x+
        sta     string2-string3-1,x
        decb
        bne     chstr1

        bsr     strcmp

        ldx     #string4
        ldb     #3
        stb     <length
chstr2  lda     ,x+
        sta     string2-string4-1,x
        decb
        bne     chstr2

strcmp  clr     <result
        ldb     <length
        incb
        ldx     #string1

chchr   decb
        beq     done

        lda     ,x+
        cmpa    string2-string1-1,x
        bge     chchr

        dec     <result

done    rts

        org     $40
result  fcb     0
length  fcb     3
string1 fcc     'CAT'

        org     $50
        fcb     0,0
string2 fcc     'BAT'

        org     $60
string3 fcc     'CAT'

        org     $70
string4 fcc     'CUT'

; 6-5. pattern match

; Compare two strings of ASCIl characters to see if they are the
; same. The length of the strings is in memory location $41; one
; string starts in memory location $42 and the other in memory location
; $52. If the two strings match, clear memory location $40; otherwise,
; set memory location $40 to all ones ($FF).

        org     $4000
        setdp   0

        bsr     patmat

        lda     #'R
        sta     <string1
        lda     #3
        sta     <length
        clr     <result

patmat  lda     #$ff
        sta     <result
        ldx     #string1
        ldu     #string2
        ldb     <length

chchr   lda     ,x+
        cmpa    ,u+
        bne     done
        decb
        bne     chchr
        stb     <result
done    rts

        org     $40
result  fcb     0
length  fcb     3

string1 fcc     'CAT'

        org     $52
string2 fcc     'CAT'

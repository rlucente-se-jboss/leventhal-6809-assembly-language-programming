; 6-3. replace leading zeros with blanks

; Edit a string of numeric characters by replacing all leading zeros
; with blanks. The string starts in memory location $41; assume that
; it consists entirely of ASCII-coded decimal digits. Memory location
; $40 contains the length of the string in bytes.

SPACE   equ     ' '
ZERO    equ     '0
EIGHT   equ     '8

        org     $4000
        setdp   0

        bsr     strrep

        lda     #8
        sta     <count

        ldx     #pointer
        lda     #ZERO
        sta     ,x+
        sta     ,x+
        lda     #EIGHT
        sta     ,x+

strrep  tst     <count
        beq     done

        lda     #SPACE
        ldb     #ZERO
        ldx     #pointer

chkch   cmpb    ,x+
        bne     done

        sta     -1,x
        dec     <count
        bne     chkch

        stb     -1,x
done    rts

        org     $40
count   fcb     2
pointer fcc     '00'

; 7-2. decimal to seven-segment

; Convert the contents of memory location $41 to a seven-segment
; code in memory location $42. If memory location $41 does not contain
; a single decimal digit, clear memory location $42.

        org     $4000
start   bsr     getseg
        lda     result
        beq     next
        lbsr    clrscn
        lbsr    dsplcd

next    lda     #$28
        sta     data
        bsr     getseg
        lda     result
        beq     allover
        lbsr    clrscn
        lbsr    dsplcd
allover rts

getseg  clrb            ; error code for no display
        lda     data
        cmpa    #9
        bhi     over
        ldx     #sseg
        ldb     a,x
over    stb     result
        rts

sseg    fcb     $3f,$06,$5b,$4f,$66
        fcb     $6d,$7d,$07,$7f,$6f

        org     $41
data    fcb     $03
result  fcb     $00

; x smashed
; b smashed
clrscn  ldx     #$400
        ldb     #$60
lp1     stb     ,x+
        cmpx    #$600
        bne     lp1
        rts

; x smashed
; a is code to display
; b smashed
;
;       01234567
;     0  AAAAAA
;    32 F      B
;    64 F      B
;    96 F      B
;   128  GGGGGG
;   160 E      C
;   192 E      C
;   224 E      C
;   256  DDDDDD
dsplcd  ldx     #$400
        ldb     #'X
chka    lsra            ; move bit to carry
        bcc     chkb
        stb     1,x
        stb     2,x
        stb     3,x
        stb     4,x
        stb     5,x
chkb    lsra
        bcc     chkc
        stb     38,x
        stb     70,x
        stb     102,x
chkc    lsra
        bcc     chkd
        stb     166,x
        stb     198,x
        stb     230,x
chkd    lsra
        bcc     chke
        stb     257,x
        stb     258,x
        stb     259,x
        stb     260,x
        stb     261,x
chke    lsra
        bcc     chkf
        stb     160,x
        stb     192,x
        stb     224,x
chkf    lsra
        bcc     chkg
        stb     32,x
        stb     64,x
        stb     96,x
chkg    lsra
        bcc     done
        stb     129,x
        stb     130,x
        stb     131,x
        stb     132,x
        stb     133,x
done    rts

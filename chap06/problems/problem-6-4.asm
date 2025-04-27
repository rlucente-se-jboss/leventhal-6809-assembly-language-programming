; Problem 6-4. check even parity in ASCII characters

; Check even parity in a string of ASCII characters. The length of
; the string is in memory location $41, and the string itself begins
; in memory location $42. If the parity of all the characters in the
; string is correct, clear memory location $40; otherwise, place all
; ones ($FF) into memory location $40.

        org     $4000
        setdp   0

        bsr     chkevn

        lda     #3
        sta     <count

        ldx     #data1
cpchr   ldb     ,x+
        stb     pointer-data1-1,x
        cmpx    #dend1
        bne     cpchr
        
chkevn  ldx     #pointer        ; point to start of data block
        clr     <result

gtbyte  lda     ,x+             ; get a byte of data
        clrb                    ; bit count = zero initially

chbit   asla                    ; shift a data bit to carry
        adcb    #0              ; if bit is 1, increment bit count
        tsta                    ; keep counting until data becomes zero
        bne     chbit

        lsrb                    ; did data have even number of '1' bits?
        bcc     nexte

        dec     <result         ; no, set failed status
        rts

nexte   dec     <count
        bne     gtbyte
done    rts

        org     $40
result  fcb     0
count   fcb     3
pointer fcb     $b1,$b2,$33

        org     $50
data1   fcb     $b1,$b6,$33
dend1   rmb     0

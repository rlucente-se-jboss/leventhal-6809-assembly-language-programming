; Problem 7-3. decimal to ascii

; Convert the contents of memory location $40 from a decimal digit
; to an ASCII character and store the result in memory location $41.
; If the number in memory location $40 is not a decimal digit, set
; the contents of memory location $41 to an ASCII space ($20).

        org     $4000
        setdp   0

        bsr     decasc

        lda     #$55
        sta     data
        clr     result

decasc  lda     #' '
        sta     result
        lda     data
        cmpa    #9
        bhi     done
        adda    #$30
        sta     result
done    rts

        org     $40
data    fcb     $07
result  fcb     0

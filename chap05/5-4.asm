; 5-4. maximum value

; Determine the number of negative elements (most significant bit
; contains 1) in a block. The length of the block is in memory location
; $41, and the block itself starts in memory location $42. Place the
; number of negative elements in memory location $40.

        org     $4000
        setdp   0

        ldb     <count          ; count = number of elements
        clra                    ; max = 0 (minimum possible)
        ldx     #pointer        ; point to first entry

        tstb
        beq     done

maxm    cmpa    ,x+             ; is current entry greater
*                               ;       than max?
        bhs     nochg
        lda     -1,x            ; yes, replace max with
*                               ;       current entry
nochg   decb
        bne     maxm

done    sta     <max            ; save maximum
        rts

        org     $40
max     rmb     1
count   fcb     5
pointer fcb     $67,$79,$15,$e3,$72

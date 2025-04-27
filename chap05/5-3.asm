; 5-3. number of negative elements

; Determine the number of negative elements (most significant bit
; contains 1) in a block. The length of the block is in memory location
; $41, and the block itself starts in memory location $42. Place the
; number of negative elements in memory location $40.

        org     $4000
        setdp   0

ver1    ldx     #pointer        ; point to first number
        clrb                    ; number of negatives = zero
chkneg  lda     ,x+             ; is next element negative
        bpl     chcnt           ; if not, just decrement the count
        incb                    ; yes, add 1 to # of negatives
chcnt   dec     <count
        bne     chkneg
        stb     <nneg

        lda     #6
        sta     <count

ver2    clra                    ; number of negative elements = zero
        ldx     #pointer        ; point to elements in array
        ldb     <count          ; get number of elements in array

cntneg  tst     ,x+             ; check current element
        bpl     next
        inca
next    decb
        bne     cntneg
        sta     <nneg
        rts

        org     $40
nneg    rmb     1
count   fcb     $06
pointer fcb     $68,$f2,$87,$30,$59,$2a

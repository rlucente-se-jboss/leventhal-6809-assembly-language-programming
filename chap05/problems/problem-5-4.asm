; Problem 5-4. find minimum

; Find the smallest element in a block of data. The length of the
; block is in nemory location $41, and the block itself begins in
; memory location $42. Store the minimum in memory location $40.
; Assume that the numbers in the block are 8-bit unsigned binary
; numbers.

        org     $4000
        setdp   0

        ldx     #block
        ldb     <length
        beq     done

        lda     #$ff            ; biggest unsigned number
        sta     <min

chkmin  lda     ,x+
        cmpa    <min
        bge     nextval

        sta     <min

nextval decb
        bne     chkmin

done    rts

        org     $40

min     fcb     $00

length  fcb     $05
block   fcb     $67,$79,$15,$e3,$72

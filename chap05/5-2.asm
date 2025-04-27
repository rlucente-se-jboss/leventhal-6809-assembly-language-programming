; 5-2. 16-bit sum of data

; Calculate the sum of a series of 8-bit numbers. The length of the
; series is in memory location $42 and the series itself begins in
; memory location $43. Store the sum in memory locations $40 and $41
; (eight most significant bits in $40).

        org     $4000
        setdp   0

ver1    lda     <count          ; get number of elements
        ldu     #pointer        ; data to be counted
        ldx     #0              ; data to be counted

sumd1   ldb     ,u+             ; get next element
        abx                     ; add it to the running sum
        deca                    ; decrement count
        bne     sumd1           ; quit if zero
        stx     <sum            ; save result

ver2    clra                    ; msb's of sum = zero
        clrb                    ; lsb's of sum = zero
        ldx     #pointer        ; point to start of array
sumd2   addb    ,x+             ; sum = sum + data
        adca    #0              ;      and add in carry
        dec     <count
        bne     sumd2
        std     <sum
        rts

        org     $40
sum     rmb     2
count   fcb     $03
pointer fcb     $c8,$fa,$96

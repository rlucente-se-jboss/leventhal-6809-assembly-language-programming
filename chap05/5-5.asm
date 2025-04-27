; 5-5. justify a binary fraction

; Shift the contents of memory location $40 until the most significant
; bit of the number is 1. Store the result in memory location $41 and
; the number of left shifts required in memory location $42. If the
; contents of memory location $40 are 0, clear both $41 and $42.

        org     $4000
        setdp   0

        bsr     just2
        bsr     justify

        lda     #01
        sta     <numb
        bsr     just2
        bsr     justify

        lda     #$cb
        sta     <numb
        bsr     just2
        bsr     justify

        clr     <numb
        bsr     just2

justify clrb            ; number of shifts
        lda     <numb   ; get number to shift
        beq     done    ; if no more one's, exit
chkms   bmi     done    ; msb is 1, we out
        incb
        asla
        bra     chkms

done    std     <result

        rts

just2   clrb            ; number of shifts = 0
        lda     <numb   ; get data
        beq     done2   ; through if data is zero
        decb            ; number of shifts = -1
chkms2  incb            ; add 1 to number of shifts
        asla            ; shift data left one bit
        bcc     chkms2  ; continue until carry becomes 1
        rora            ; then shift data back once
done2   std     <result ; save justified data and
                        ;       number of shifts
        rts
        
        
        org     $40
numb    fcb     $22
result  rmb     1
nshft   rmb     1

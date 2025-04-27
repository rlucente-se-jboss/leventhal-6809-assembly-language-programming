; 8-5. self-checking numbers

; Calculate a checksum digit from a string of BCD digits. The length
; of the string (number of bytes) is in memory location $41, and the
; string of digits (2 in each byte) starts in memory location $42.
; Calculate the checksum digit by the Double Add Double Mod 10
; technique and store it in memory location $40.
;
; The Double Add Double Mod 10 technique works as follows:
; 1. Clear the checksum to start.
; 2. Multiply the leading digit by two and add the result to the
;    checksum.
; 3. Add the next digit to the checksum.
; 4. Continue the alternating process until you have used all the
;    digits.
; 5. The least significant digit of the checksum is the self-checking
;    digit.

        org     $4000
        setdp   0

        bsr     selfchk

        clr     <cksum
        lda     #$04
        sta     <count
        ldx     #pointer
        lda     #$50
        sta     ,x+
        lda     #$29
        sta     ,x+
        lda     #$16
        sta     ,x+
        lda     #$83
        sta     ,x

selfchk ldx     #pointer        ; point to start of string
        clr     <cksum          ; checksum = zero
chkdg   lda     ,x              ; get next 2 digits of data
        lsra                    ; shift off least significant digit
        lsra
        lsra
        lsra
        tfr     a,b             ; copy most significant digit
        adda    <cksum          ; add msd to checksum retaining decimal form
        daa
        sta     <cksum
        tfr     b,a             ;   and add msd to checksum again
        adda    <cksum
        daa                     ;     retaining decimal form
        adda    ,x+             ; add in lsd retaining decimal form (we don't
        daa                     ; care about msd digit since the lower digit is
                                ; what matters here per 5. above)
        sta     <cksum
        dec     count           ; continue until all digits added
        bne     chkdg
        anda    #%00001111      ; save lsd of checksum
        sta     <cksum
        
        rts

        org     $40
cksum   fcb     $00
count   fcb     $03
pointer fcb     $36,$68,$51

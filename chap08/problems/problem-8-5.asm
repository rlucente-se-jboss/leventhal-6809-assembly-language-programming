; Problem 8-5. self-checking numbers aligned 1, 3, 7 mod 10

; Calculate a checksum digit from a string of BCD digits. The length
; of the string of digits (number of bytes) is in memory location
; $41, the string of digits (2 per byte) starts in memory location
; $42. Calculate the checksum digit by the Aligned 1, 3, 7 Mod 10
; method and store it in memory location $40. The Aligned 1, 3, 7 Mod
; 10 technique works as follows:
;
; 1. Clear the checksum to start.
; 2. Add the leading digit to the checksum.
; 3. Multiply the next digit by 3 and add the result to the checksum.
; 4. Multiply the next digit by 7 and add the result to the checksum.
; 5. Continue the process (Steps 2-4) until you have used all the digits.
; 6. The self-checking digit is the least significant digit of the checksum.

                org     $4000
                setdp   0
        
                bsr     selfcheck
        
                clr     <checksum
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

selfcheck       ldx     #pointer
                clr     <checksum

chkdigit        lda     ,x              ; get next 2 digits of data
                lsra                    ; shift off least significant digit
                lsra
                lsra
                lsra
                bsr     getmultiplier
                bsr     bcdmultiply     
                lda     ,x+
                bsr     getmultiplier
                bsr     bcdmultiply
                dec     count           ; continue until all digits added
                bne     chkdigit
                lda     <checksum
                anda    #%00001111      ; save lsd of checksum
                sta     <checksum
        
                rts

bcdmultiply     anda    #$0f
nextmultiply    pshs    a
                adda    <checksum
                daa
                sta     <checksum
                puls    a
                decb
                bne     nextmultiply
                rts
        
getmultiplier   ldb     <multfactor
                lslb
                incb
                cmpb    #7
                ble     savefactor
                ldb     #1
savefactor      stb     <multfactor
                rts

                org     $40
checksum        fcb     $00
count           fcb     $03
pointer         fcb     $36,$68,$51
multfactor      fcb     $00     

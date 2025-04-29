; Problem 9-2. add entry to ordered list

; Place the byte in memory location $41 in an ordered list if it
; is not already there. The length of the list is in memory location
; $42; the list itself begins in memory location $43 and consists of
; unsigned binary numbers in increasing order. Place the new entry
; in the correct position in the list, adjust the elements below it
; down, and increase the length of the list by 1.

                org     $4000
                setdp   0

                bsr     addentry

                lda     #4              ; set up second example
                sta     <counter
                lda     #$6b
                sta     <pointer+2
                lda     #$a1
                sta     <pointer+3

addentry        ldb     <counter        ; get length of list
                ldx     #pointer        ; point to base of list
                lda     <entry          ; get entry to add

checkentry      cmpa    ,x+             ; compare new entry to current entry
                beq     done            ;     do nothing if already in list
                bhi     nextentry       ;     move on if new entry higher

shiftentries    pshs    a               ; preserve new entry
                decb                    ; since x is one past where we want to be
                leau    b,x             ; u is one past last entry in list
                incb                    ; restore current count in list

shiftit         lda     ,-u             ; move current entry one address higher
                sta     1,u
                decb                    ; finish all elements
                bne     shiftit

                puls    a               ; restore new entry and location+1
                sta     -1,x            ; store in correct location
                inc     <counter        ; list one item longer now
                bra     done    

nextentry       decb                    ; keep going until all elements processed
                bne     checkentry      
done            rts

                org     $41
entry           fcb     $6b
counter         fcb     $04
pointer         fcb     $37,$55,$7d,$a1

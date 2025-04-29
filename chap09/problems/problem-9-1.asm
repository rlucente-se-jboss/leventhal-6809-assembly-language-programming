; Problem 9-1. remove entry from list

; Remove the byte in memory location $40 from a list if it is
; present. The length of the list is in memory location $41 and the
; list itself begins in memory location $42. Move the entries below
; the one removed up one position and reduce the length of the list
; by 1.

                org     $4000
                setdp   0

                bsr     removeentry

                lda     #$6b            ; set up second example
                sta     <pointer+1

removeentry     ldb     <counter        ; get length of list
                beq     done            ; exit if no entries
                ldx     #pointer        ; point to base of list
                lda     <entry          ; get entry to remove

checkentry      cmpa    ,x+             ; check if current entry to be removed
                bne     nextentry       ;     if not, next entry

                dec     <counter        ; list now one entry shorter
                beq     done            ; if list now empty, we're done

                decb                    ; we're processing one less item now
adjustlist      lda     ,x+             ; get next entry and bump pointer
                sta     -2,x            ; move value to prior entry
                decb                    ; keep going through the list
                bne     adjustlist
                bra     done            ; assumes each entry is unique

nextentry       decb                    ; keep going until all elements processed
                bne     checkentry      
done            rts

                org     $40
entry           fcb     $6b
counter         fcb     $04
pointer         fcb     $37,$61,$28,$1d

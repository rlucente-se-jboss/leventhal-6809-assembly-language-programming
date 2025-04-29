; 9-2. check an ordered list

; Check the contents of memory location $41 to see if it is in an
; ordered list. The length of the list is in memory location $42; the
; list itself begins in memory location $43 and consists of unsigned
; binary numbers in increasing order. If the contents of location $41
; are in the list, clear memory location $40; otherwise, set memory
; location $40 to $FF.

                org     $4000
                setdp   0

                bsr     searchlist

                clr     <mark           ; set up next example
                lda     #$6b
                sta     <pointer+2

searchlist      clr     <mark           ; mark element as in list
                ldx     #pointer        ; point to start of list
                ldb     <count          ; count = length of list
                lda     <entry          ; get entry
srlst           cmpa    ,x+             ; is entry equal to element?
                beq     done            ;     yes, done
                bcs     notin           ; entry not in list if element is larger
                decb                    ; all elements examined?
                bne     srlst
notin           com     <mark           ;     yes, mark element as not in list
done            rts

                org     $40
mark            fcb     $00
entry           fcb     $6b
count           fcb     $04
pointer         fcb     $37,$55,$7d,$a1

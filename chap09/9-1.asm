; 9-2. add entry to list

; Add the contents of memory location $40 to a list if it is not
; already present in the list. The length of the list is in memory
; location $41 and the list itself begins in memory location $42.

                org     $4000
                setdp   0

start           bsr     listinsert      ; do first example

                lda     #4              ; set up second example
                sta     <count
                lda     #$6b
                sta     <pointer+1      ; change initial list
                clr     <pointer+4      ; clear previously added value

listinsert      ldx     #pointer        ; point to base of list
                lda     <entry          ; get entry to insert
                ldb     <count          ; get entries in list
                beq     addentry        ; add entry if list empty

searchlist      cmpa    ,x+             ; check if entry already in list
                beq     done            ; if so, we're done
                decb                    ; keep going until list exhausted
                bne     searchlist

addentry        sta     ,x              ; insert new entry
                inc     <count          ; bump list length
done            rts

                org     $40
entry           fcb     $6b
count           fcb     $04
pointer         fcb     $37,$61,$38,$1d

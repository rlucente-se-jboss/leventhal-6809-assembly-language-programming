; Problem 9-5. using a jump table with a key

; Use the contents of memory location $42 as the key to a jump table
; starting in memory location $43. Each entry in the jump table
; contains an 8-bit key value followed by a 16-bit address (MSBs in
; first byte) to which the program should transfer control if the key
; is equal to that key value.

                org     $4000
                setdp   0

                lda     <searchkey              ; key to find
                ldx     #entry1-entrysize       ; point to base of table - size of entry

                ldb     <tablelength            ; get length of table + 1
                incb

findkey         decb                            ; have we gone through the list?
                beq     done                    ;     if so, exit out

                leax    entrysize,x             ; advance to next entry
                cmpa    ,x                      ; does key match?
                bne     findkey                 ;     yes, key found

                jmp     [jumpaddress,x]         ; transfer to target address

done            rts

; define a structure here
                org     0
key             rmb     1
jumpaddress     rmb     2
entrysize       rmb     0

                org     $40
tablelength     fcb     $03
                fcb     $00                     ; unused
searchkey       fcb     $38
entry1          fcb     $32
                fdb     $004c
entry2          fcb     $35
                fdb     $0050
entry3          fcb     $38
                fdb     $0054

; set simple returns at each jump destination
                org     $4c
                rts

                org     $50
                rts

                org     $54
                rts

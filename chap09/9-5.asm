; 9-5. using an ordered jump table

; Use the contents of memory location $42 as an index to a jump
; table starting in memory location $43. Each entry in the jump table
; contains a 16-bit address with the MSBs in the first byte. The
; program should transfer control to the address with the appropriate
; index; that is, if the index is 6, the program should jump to address
; entry #6 in the table. Assume that the table has fewer than 128
; entries.

                org     $4000
                setdp   0       

                lda     <index          ; get index
                asla                    ; double index for 2-byte entries
                ldx     #jumptable      ; get base address of jump table
                jmp     [a,x]           ; transfer contro jump table entry

                org     $42
index           fcb     $02
jumptable       fdb     $004c,$0050,$0054,$0058

                org     $4c
                rts

                org     $50
                rts

                org     $54
                rts

                org     $58
                rts

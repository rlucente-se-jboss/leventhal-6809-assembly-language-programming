; 9-4. 8-bit sort

; Sort an array of unsigned 8-bit binary numbers into descending
; order. The length of the array is in memory location $41 and the
; array itself begins in memory location $42.

                org     $4000
                setdp   0

bubblesort      lda     #1              ; interchange flag = 1
                sta     <interchange
                lda     <counter        ; adjust array length to number of pairs
                beq     done            ;     nothing to do if no elements in the array
                deca
                beq     done            ;     nothing to do if only one element
                ldx     #pointer        ; point to start of array

bubblepass      ldb     ,x+             ; is pair of elements in order?
                cmpb    ,x
                bcc     count           ;     yes, try next pair
                clr     <interchange    ;     no, clear interchange flag
                pshs    a               ; save array counter
                lda     ,x
                stb     ,x
                sta     -1,x
                puls    a               ; restore array counter
count           deca
                bne     bubblepass      ; check for completed pass
                tst     <interchange    ; were all elements in order?
                beq     bubblesort      ;     no, go through array again
done            rts

                org     $40
interchange     fcb     $00
counter         fcb     $06
pointer         fcb     $2a,$b5,$60,$3f,$d1,$19

; Problem 9-4. 16-bit sort

; Sort an array of unsigned 16-bit binary numbers into descending
; order. The length of the array is in memory location $40 and the
; array itself begins in memory location $41. Each 16-bit number is
; stored with the most significant bits in the first byte.

                org     $4000
                setdp   0

bubblesort      lda     #1              ; interchange flag = 1
                sta     <interchange
                lda     <counter        ; adjust list length to number of pairs (e.g. n-1)
                beq     done            ;     nothing to do if no elements in the array
                deca
                beq     done            ;     nothing to do if only one element
                ldx     #pointer        ; point to start of list

bubblepass      ldu     ,x++            ; is pair of elements in order?
                cmpu    ,x
                bcc     nextiter        ;     yes, try next pair
                clr     <interchange    ;     no, clear interchange flag
                pshs    a               ; save array counter
                ldd     ,x
                stu     ,x
                std     -2,x
                puls    a               ; restore array counter
nextiter        deca
                bne     bubblepass      ; check for completed pass
                tst     <interchange    ; were all elements in order?
                beq     bubblesort      ;     no, go through array again
done            rts


                org     $40
counter         fcb     $03
pointer         fdb     $19d1
                fdb     $3f60
                fdb     $b52a
interchange     fcb     $00

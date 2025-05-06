; Problem 10-4. string comparison

; Compare two strings of ASCII characters to see which is larger
; (i.e., which follows the other in "alphabetical' ordering). The
; length of the strings is in Accumulator B. The starting address of
; string 1 is in Index Register X and the starting address of string
; 2 is in Index Register Y. If string 1 is larger than or equal to
; string 2, clear Accumulator B; otherwise, set Accumulator B to $FF.

                org     $4000
                setdp   0

                ldb     <count
                ldx     <strptr1
                ldy     <strptr2
                jsr     strcmp

                lda     #'C             ; set up second example
                sta     <string2

                ldb     <count
                ldx     <strptr1
                ldy     <strptr2
                jsr     strcmp

                lda     #'U             ; set up second example
                sta     <string2+1

                ldb     <count
                ldx     <strptr1
                ldy     <strptr2
                jsr     strcmp

                rts

                org     $40
                rmb     1               ; unused
count           fcb     $03             ; $41
strptr1         fdb     string1         ; $42
strptr2         fdb     string2         ; $44
string1         fcc     'CAT'           ; $46
                rmb     1               ; unused
string2         fcc     'BAT'           ; $4a

* subroutine strcmp
*
* purpose: Compare two strings of ASCII characters to see which is
*    larger (i.e., which follows the other in "alphabetical' ordering).
*    The length of the strings is in Accumulator B. The starting address
*    of string 1 is in Index Register X and the starting address of
*    string 2 is in Index Register Y. If string 1 is larger than or equal
*    to string 2, clear Accumulator B; otherwise, set Accumulator B to
*    $FF.
*
* initial conditions: (X) is first letter in string 1, (Y) is the
*    first letter in string 2, (B) is the length of the strings.
*
* final conditions: (B) is clear if string 1 >= string 2; $ff otherwise
*
* registers affected: A, B, X, Y, FLAGS

                org     $20
strcmp          lda     ,x+             ; get character from string 1
                cmpa    ,y+             ; is string 2 greater?
                blo     str2gtr         ;   yes, branch
                decb                    ; process all characters
                bne     strcmp
                rts                     ; return since str1 >= str2 and B = 0
str2gtr         ldb     #$ff            ; indicate str2 > str1
                rts

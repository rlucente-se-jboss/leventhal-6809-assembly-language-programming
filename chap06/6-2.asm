; 6-2. find first non-blank character

; Search a string of ASCIl characters for a non-blank character.
; The string starts in memory location $42. Place the address of the
; first non-blank character in memory locations $40 and $41 (most
; significant bits in $40).

SP      equ     ' '

        org     $4000
        setdp   0

        ldx     #string
        lda     #SP

strstr  cmpa    ,x+
        beq     strstr

        leax    -1,x
        stx     <pointer
        rts

        org     $40
pointer fdb     0
string  fcc     '   F '

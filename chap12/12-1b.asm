; 12-1b. delay subroutine

;  The subroutine produces a delay of 1 ms using register X.

mscnt           equ     $007a

                org     $4000
                setdp   0

delay           pshs    x
                ldx     #mscnt          ; get count for 1 ms delay
dly             leax    -1,x            ; count x down for 1 ms
                bne     dly
                puls    pc,x

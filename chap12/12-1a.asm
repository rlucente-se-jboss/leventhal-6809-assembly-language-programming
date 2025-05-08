; 12-1a. delay subroutine

; The subroutine produces a delay of 1 ms times the contents of
; Accumulator A.

mscnt           equ     $c3

                org     $4000
                setdp   0

delay           pshs    b,cc            ; save incidental registers
dly1            ldb     #mscnt          ; get count for 1 ms delay
dly             decb
                bne     dly             ; count with b for 1 ms
                deca                    ; count number of milliseconds
                bne     dly1
                puls    pc,b,cc         ; restore incidental registers
                                        ;   and return

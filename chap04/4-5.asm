; 4-5. clear a memory location

; Clear memory location $40; that is, reset all the bits in location
; $40 to zeros.

        org     $4000
        setdp   0

start   clr     $40             ; clear memory location 0040
        rts

        org     $40
        fcb     $3d

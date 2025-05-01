; Problem 4-5. set a memory location to all ones

; Set all bits of memory location $40 to ones (0xff)

        org $4000
        setdp 0

first   clra            ; set to zero
        coma            ; now it's all ones
        sta     $40     ; save result

second  clr     $40     ; clear memory
        com     $40     ; now it's all ones

        rts

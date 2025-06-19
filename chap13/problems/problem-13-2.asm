; Problem 13-2. debouncing a switch in software

; Debounce a mechanical switch by waiting until two readings, taken
; a debounce time apart, give the same result. Assume that the debounce
; time (in ms) is in memory location $40 and store the switch position
; in memory location $41.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

pia_ctrl_a      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

                org     $40
                setdp   0
debouncedelay   fcb     $10             ; debounce delay in ms
switchposition  rmb     1

mask            equ     %00000001

                org     $4000
                ldb     #$01            ; feature on 6809.uk emulator to set
                                        ; a memory address from register B
                                        ; when you left click to simulate a
                                        ; button depress

                clr     <pia_ctrl_a     ; address data direction register
                clr     <pia_ddr_a      ; make all data lines inputs
                lda     #%00000100      ; address data register
                sta     <pia_ctrl_a

chkbutton       lda     <pia_data_a     ; read button position
                anda    #mask
                pshs    a               ; save for later comparison

                bsr     delay           ; small delay for debounce to ensure closed

                lda     <pia_data_a     ; read button position (should still be the same)
                anda    #mask
                cmpa    ,s              ; is it same as last time?
                bne     tryagain        ;   no, try again

                sta     switchposition  ; save current switch position

tryagain        puls    a
                bra     chkbutton 

delay           ldx     <debouncedelay  ; number of ms to delay
outerdelay      ldd     #10             ; tune this to achieve 1 ms delay
innerdelay      subd    #1
                bne     innerdelay
                leax    -1,x
                bne     outerdelay
                rts

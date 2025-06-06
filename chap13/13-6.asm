; 13-6. an encoded keyboard

; The processor will fetch data, when it is available, from an
; encoded keyboard that provides a strobe along with each data transfer.

; Wait for an active-low strobe on control line CA1 and then load
; the keyboard data into accumulator A. Note that reading the data
; from the data register clears the status bit (this circuitry is
; part of the 6821 PIA).

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; port A is at addresses $20/$21

pia_ctrl_a      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

                org     $4000
start           clr     <pia_ctrl_a     ; address data direction register
                clr     <pia_ddr_a      ; make all data lines inputs
                lda     #%00000100      ; address the data register
                sta     <pia_ctrl_a

kbwait          lda     <pia_ctrl_a     ; has key been pressed?
                bpl     kbwait          ;   no, wait

                lda     <pia_data_a     ;   yes, fetch data from keyboard
                rts

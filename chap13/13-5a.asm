; 13-5a. wait for key closure

; Wait for a key to be pressed. The procedure is as follows:
; 1. Ground all the rows by clearing the output bits
; 2. Fetch the column inputs by reading the input port
; 3. Return to step 1 if all the column inputs are ones

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; port B of PIA is at addresses $22/$23 and port A is at addresses
; $20/$21

pia_ctrl_a      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

pia_ctrl_b      equ     $23             ; PIA port B control register
pia_ddr_b       equ     $22             ; PIA port B data direction register
pia_data_b      equ     $22             ; PIA port B data register

                org     $4000
start           clr     <pia_ctrl_a     ; address data direction registers
                clr     <pia_ctrl_b
                clr     <pia_ddr_a      ; make A side data lines inputs
                lda     #$ff
                sta     <pia_ddr_b      ; make B side data lines outputs
                lda     #%00000100      ; address data registers
                sta     <pia_ctrl_a
                sta     <pia_ctrl_b

                clr     <pia_data_b     ; ground all keyboard rows
waitk           lda     <pia_data_a     ; get data from keyboard columns
                anda    #%00000111      ; mask column bits
                cmpa    #%00000111      ; are any keys closed?
                beq     waitk           ;   no, wait
                rts

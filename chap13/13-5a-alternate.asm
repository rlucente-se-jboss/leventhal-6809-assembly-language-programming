; 13-5a. wait for key closure (using single PIA)

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

allground       equ     %11110000       ; all switches grounded
allopen         equ     %00001111       ; all switches open

                org     $4000
start           clr     <pia_ctrl_a     ; address data direction register
                lda     #%11110000      ; upper nibble is output, lower nibble
                sta     <pia_ddr_a      ;   is input
                lda     #%00000100      ; address data registers
                sta     <pia_ctrl_a

                lda     <pia_data_a     ; ground all outputs by zeroing the
                anda    #allopen        ;   upper nibble
                sta     <pia_data_a

waitk           lda     <pia_data_a     ; get data from keyboard columns
                anda    #allopen        ; mask column bits
                cmpa    #allopen        ; are any keys closed?
                beq     waitk           ;   no, wait
                rts

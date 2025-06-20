; Problem 13-4. record switch positions on lights

; A set of eight switches should have their positions reflected on
; eight LEDs. That is to say, if the switch is closed (zero), the LED
; should be on; otherwise, the LED should be off. Assume that the CPU
; output port is connected to the cathodes of the LEDs.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; Assume that the switches are wired to port A of the PIA and the
; LEDs are wired to port B of the PIA. Switch 0 to 7 map to bits 0
; to 7 on PIA port A and LEDs 0 to 7 map to bits 0 to 7 on PIA port
; B. Finally, switch 0 to 7 control LEDs 0 to 7, respectively.

pia_1_ctrl_a    equ     $21             ; PIA 1 port A control register
pia_1_ddr_a     equ     $20             ; PIA 1 port A data direction register
pia_1_data_a    equ     $20             ; PIA 1 port A data register

pia_1_ctrl_b    equ     $23             ; PIA 1 port B control register
pia_1_ddr_b     equ     $22             ; PIA 1 port B data direction register
pia_1_data_b    equ     $22             ; PIA 1 port B data register

                org     $40
                setdp   0
debouncedelay   fcb     $10             ; debounce delay in ms

                org     $4000

                clr     <pia_1_ctrl_a   ; address data direction register
                clr     <pia_1_ddr_a    ; make all data lines inputs
                lda     #%00000100      ; address data register
                sta     <pia_1_ctrl_a

                clr     <pia_1_ctrl_b   ; address data direction register
                lda     #$ff            ; make all data lines outputs
                sta     <pia_1_ddr_b
                lda     #%00000100      ; address data register
                sta     <pia_1_ctrl_b

                leas    -1,s            ; dummy value to streamline loop

getswitchpos    leas    +1,s            ; fix stack
                lda     <pia_1_data_a   ; read switch positions and save
                pshs    a               ;   on stack

                bsr     delay           ; small delay for debounce

                lda     <pia_1_data_a   ; are switch positions the same?
                cmpa    ,s
                bne     getswitchpos    ;   no, try again

                coma                    ; complement so switch low is LED on
                sta     <pia_1_data_b   ; activate LEDs as necessary

                bra     getswitchpos

delay           ldx     <debouncedelay  ; number of ms to delay
outerdelay      ldd     #10             ; tune this to achieve 1 ms delay
innerdelay      subd    #1
                bne     innerdelay
                leax    -1,x
                bne     outerdelay
                rts

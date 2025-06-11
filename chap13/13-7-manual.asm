; 13-7. send data to d/a converter (using manual mode)

; Send data from memory location $40 to the D/A converter using
; software controlled signal level

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; port B is at addresses $22/$23

pia_ctrl_b      equ     $23             ; PIA port B control register
pia_ddr_b       equ     $22             ; PIA port B data direction register
pia_data_b      equ     $22             ; PIA port B data register

                org     $40
data            fcb     $ff             ; data to output to d/a converter

                org     $4000
start           clr     <pia_ctrl_b     ; address data direction register
                lda     #$ff            ; make all data lines outputs
                sta     <pia_ddr_b
                lda     #%00110100      ; address the data register, provide
                sta     <pia_ctrl_b     ;  pulse low:
                                        ;    bit 5 = 1 makes CB2 an output
                                        ;    bit 4 = 1 makes CB2 a level
                                        ;    bit 3 = 0 CB2 pulled low
                                        ;    bit 2 = 1 address data register

                ldb     <data           ; get data
                stb     <pia_data_b     ; send data to dac
                ora     #%00001000      ; open dac latch (bring enable high)
                sta     <pia_ctrl_b
                anda    #%11110111      ; latch data (bring enable low)
                sta     <pia_ctrl_b
                rts

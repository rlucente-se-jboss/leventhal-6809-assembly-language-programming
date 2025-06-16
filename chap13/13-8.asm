; 13-8. input from ADC converter

; Start the conversion process, wait for End of Conversion (EOC)
; to go high, then read the data and store it in memory location $40.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; port A is at addresses $20/$21

pia_ctrl_a      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

                org     $40
data            rmb     1               ; data read from ADC

                org     $4000
start           clr     <pia_ctrl_a     ; address data direction register
                clr     <pia_ddr_a      ; make all data lines inputs
                lda     #%00110110      ; bring start low, trigger on eoc
                sta     <pia_ctrl_a     ;   going high (CA1 goes high)
                                        ;    bit 5 = 1 makes CA2 an output
                                        ;    bit 4 = 1 makes CA2 a manual level
                                        ;    bit 3 = 0 brings CA2 low initially
                                        ;    bit 1 = 1 to set bit 7 on a
                                        ;      low-to-high transition on the
                                        ;      End of Conversion line (CA1)
                                        ;    bit 2 = 1 address data register
                ora     #%00001000      ; bring start conversion high (CA2)
                sta     <pia_ctrl_a
                anda    #%11110111      ; bring start conversion low (CA2)
                sta     <pia_ctrl_a
wteoc           lda     <pia_ctrl_a     ; has conversion been completed?
                bpl     wteoc           ;   no, wait (bit 7 not set)
                lda     <pia_data_a     ;   yes, fetch data from converter
                coma                    ; complement data to produce true value
                sta     <data           ; save data in memory
                rts

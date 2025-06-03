; 13-4a. display a decimal digit (blank at end of table)

; Display the contents of memory location $40 on a seven-segment
; display if it contains a decimal digit. Otherwise, blank the display.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; port B of PIA is at addresses $22/$23 and port A is at addresses
; $20/$21

pia_ctrl_b      equ     $23             ; PIA port B control register
pia_ddr_b       equ     $22             ; PIA port B data direction register
pia_data_b      equ     $22             ; PIA port B data register

blank           equ     $ff             ; blank for a common-anode display

                org     $40
data            fcb     $05

                org     $50
sseg            fcb     $40,$79,$24,$30 ; common-anode encodings
                fcb     $19,$12,$02,$78 ; for seven-segment display
                fcb     $00,$18
                fcb     blank

                org     $4000
start           clr     <pia_ctrl_b     ; address data direction register
                lda     #$ff            ; make all data lines outputs
                sta     <pia_ddr_b
                lda     #%00000100      ; address data register
                sta     <pia_ctrl_b

                lda     <data           ; get data
                cmpa    #9              ; is data a decimal digit (9 or less)?
                bls     cnvrt
                lda     #10             ;    no, replace data with index for
                                        ;      blank code
cnvrt           ldx     #sseg           ; convert data to seven-segment code
                ldb     a,x
                stb     pia_data_b      ; send code to display
                rts

; Problem 13-5. count on a seven-segment display

; The program should count from 0 to 9 continuously on a seven-segment display,
; starting with zero.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; port B of PIA is at addresses $22/$23 and port A is at addresses
; $20/$21

pia_ctrl_b      equ     $23             ; PIA port B control register
pia_ddr_b       equ     $22             ; PIA port B data direction register
pia_data_b      equ     $22             ; PIA port B data register

blank           equ     $ff             ; blank for a common-anode display

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

                lda     #$ff            ; start at -1 for initial increment
                ldx     #sseg           ; x indexes the segment codes

countloop       inca                    ; increment digit to be displayed
                daa                     ; make sure we're in the range 0-9
                anda    #$0f
                bsr     displaydigit    ; display the digit
                bsr     delay           ; wait about one second
                bra     countloop       ; rinse and repeat

displaydigit    ldb     a,x             ; convert data to seven-segment code
                stb     pia_data_b      ; send code to display
                rts

; delay roughly one second (with a clock of 0.895 MHz)
delay           ldu     #0
delayinner      leau    -1,u
                cmpu    #0
                bne     delayinner
                rts

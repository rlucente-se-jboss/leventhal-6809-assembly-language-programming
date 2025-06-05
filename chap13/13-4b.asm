; 13-4a. display ten decimal digits

; Continuously display the contents of memory locations $40 through
; $49 on ten 7-segment displays that are multiplexed with a counter
; and a decoder. The most significant (leftmost) digit in in memory
; location $40.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; port B of PIA is at addresses $22/$23 and port A is at addresses
; $20/$21

pia_ctrl_b      equ     $23             ; PIA port B control register
pia_ddr_b       equ     $22             ; PIA port B data direction register
pia_data_b      equ     $22             ; PIA port B data register

                org     $40
data            fcb     $66,$3f,$7f,$7f,$06,$5b,$07,$4f,$6d,$7d

                org     $4000
start           clr     <pia_ctrl_b     ; address data direction register
                lda     #$ff            ; make all data lines outputs
                sta     <pia_ddr_b
                lda     #%00101100      ; address data register (bit 2 = 1)
                                        ; make cb2 a brief pulse
                                        ;   cb2 is output (bit 5 = 1)
                                        ;   cb2 is a pulse (bit 4 = 0)
                                        ;   cb2 lasts one cycle (bit 3 = 1)
                sta     <pia_ctrl_b

scan            ldx     #data           ; point to start of data
                ldb     #10             ; number of displays = 10
dsply           lda     ,x+             ; get data for display
                sta     <pia_data_b     ; send data to display (triggering cb2)
                jsr     delay           ; wait 1 ms
                decb                    ; count displays
                bne     dsply
                bra     scan            ; start another scan

; simple delay routine
delay           pshs    a,cc
                lda     #10
delay1          deca
                bne     delay1
                puls    a,cc,pc

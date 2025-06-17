; 13-9a. read data from a teletypewriter (TTY) 

; Fetch data from a teletypewriter using bit 7 of a PIA data port
; and place the data in memory location $60.

; Assume that the serial port is bit 7 of the PIA and that no parity
; or framing check is necessary.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; port A is at addresses $20/$21

pia_ctrl_a      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

                org     $60
data            rmb     1               ; data read from TTY

                org     $4000
start           clr     <pia_ctrl_a     ; address data direction register
                clr     <pia_ddr_a      ; make all data lines inputs
                lda     #%00000100      ; address data register
                sta     <pia_ctrl_a

wtstb           lda     <pia_data_a     ; is there a start bit?
                bmi     wtstb           ;   no, wait
                jsr     dly2            ;   yes, delay half bit time to
                                        ;     center reception
                lda     #%10000000      ; count with '1' bit in msb
ttyrcv          jsr     delay           ; wait 1 bit time
                rol     <pia_data_a     ; get next data bit (in carry)
                rora                    ; combine with previous data
                bcc     ttyrcv          ; continue until count bit
                                        ;   traverses data
                sta     <data           ; save result
                rts

dly2            ldx     #$0236          ; count for 4.55 ms
                bra     dly             ;   (clock rate = 1 MHz)
delay           ldx     #$046c          ; count for 9.1 ms
dly             leax    -1,x
                bne     dly
                rts

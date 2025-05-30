; 13-2a. determine multiple-position (rotary, selector, or thumbwheel) switch position

; The program waits for the switch to be in a specific position and
; then stores the position number in memory location $40.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

pia_ctrl_a      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

; delay routine for debouncing the switch
mscnt           equ     $02             ; small number for emulator
                org     $30
delay           pshs    b,cc            ; save incidental registers
dly1            ldb     #mscnt          ; get count for 1 ms delay
dly             decb
                bne     dly             ; count with b for 1 ms
                deca                    ; count number of milliseconds
                bne     dly1
                puls    pc,b,cc         ; restore incidental registers
                                        ;   and return

                org     $40
                setdp   0
switchpos       fcb     $00

                org     $4000
start           clr     <pia_ctrl_a     ; address data direction register
                clr     <pia_ddr_a      ; make all data lines inputs
                lda     #%00000100      ; address data register
                sta     <pia_ctrl_a
                clr     <switchpos      ; clear switch position

chksw           ldb     <pia_data_a     ; get current switch value
                cmpb    #$ff            ; is switch in a position?
                beq     chksw           ;   no, wait until it is
                lda     #10             ; wait 10 ms to debounce button
                jsr     delay
                cmpb    <pia_data_a     ; is switch in same position?
                bne     chksw           ;   no, wait until it is

                lda     #$ff            ; switch position = -1
chkpos          inca                    ; add 1 to switch position
                lsrb                    ; is next bit grounded position?
                bcs     chkpos          ;   no, keep looking
                sta     <switchpos      ; save switch position
                rts

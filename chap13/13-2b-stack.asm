; 13-2b. wait for switch position to change (temporary variable on stack)

; The program waits for the switch position to change and places
; the new position (decoded) into memory location $40. The program
; waits until the switch reaches its new position.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

pia_ctrl_a      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

                org     $40
                setdp   0
switchpos       fcb     $00

                org     $4000
start           clr     <pia_ctrl_a     ; address data direction register
                clr     <pia_ddr_a      ; make all data lines inputs
                lda     #%00000100      ; address data register
                sta     <pia_ctrl_a

chkfst          lda     <pia_data_a     ; get switch data
                cmpa    #$ff            ; is the switch in a position?
                beq     chkfst          ;   no, wait until it is
                pshs    a               ;   yes, save switch position on stack

chksec          lda     <pia_data_a     ; get new switch data
                cmpa    ,s              ; is position same as before?
                beq     chksec          ;   yes, wait for position to change
                ldb     #$ff            ;   no, start position at -1
                leas    1,s             ;       discard old switch position

chkpos          incb                    ; add 1 to switch position
                lsra                    ; is next bit grounded position?
                bcs     chkpos          ;   no, keep looking
                stb     <switchpos      ;   yes, store switch position
                rts

; 13-1a. determine pushbutton switch closure

; Set memory location $40 to one if the button is not being pressed,
; and to zero if it is. Button is connected to bit 0 of port A data
; register on 6821 PIA.

; NB: There is no 6821 PIA at address $20 so this is more informational
;     than anything else.

pia_a_ctrl      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

                org     $40
                setdp   0
buttondown      fcb     $00

mask            equ     %00000001

                org     $4000
                ldb     #$01            ; feature on 6809.uk to set a memory
                                        ; address from register B when you left
                                        ; click to simulate a button depress

                clr     <pia_a_ctrl     ; address data direction register
                clr     <pia_ddr_a      ; make all data lines inputs
                lda     #%00000100      ; address data register
                sta     <pia_a_ctrl
                clr     <buttondown     ; clear button marker
                lda     <pia_data_a     ; read button position
                anda    #mask           ; is button closed (logical zero)
                beq     done            ;    yes, done
                inc     <buttondown     ;    no, set button marker
done            rts

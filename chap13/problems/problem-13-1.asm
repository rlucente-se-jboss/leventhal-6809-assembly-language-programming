; Problem 13-1. an on-off pushbutton

; Each closure of the pushbutton complements (inverts) all the bits
; in memory location $40. The location initially contains zero. The
; program should continuously examine the pushbutton and complement
; location $40 with each closure. You may wish to complement a display
; output port instead, so as to make the results easier to see.

; This includes debounce logic for both close and open.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

pia_ctrl_a      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

                org     $40
                setdp   0
buttonresult    fcb     $00

mask            equ     %00000001

                org     $4000
                ldb     #$01            ; feature on 6809.uk emulator to set
                                        ; a memory address from register B
                                        ; when you left click to simulate a
                                        ; button depress

                clr     <pia_ctrl_a     ; address data direction register
                clr     <pia_ddr_a      ; make all data lines inputs
                lda     #%00000100      ; address data register
                sta     <pia_ctrl_a

chkbutton       bsr     delay           ; small delay for debounce of closure

                lda     <pia_data_a     ; read button position
                anda    #mask           ; is button closed (logical one)
                beq     chkbutton       ;    no, wait for closure

                bsr     delay           ; small delay for debounce to ensure closed

                lda     <pia_data_a     ; read button position (should still be closed)
                anda    #mask           ; is button still closed (logical one)
                beq     chkbutton       ;   no, wait for closure

                com     <buttonresult   ; invert memory for each closure

waitforopen     bsr     delay           ; small delay for debounce to ensure open

                lda     <pia_data_a     ; read button position
                anda    #mask           ; is button now open (logical zero)
                bne     waitforopen     ;   no, wait until open

                bsr     delay           ; small delay for debounce to ensure open

                lda     <pia_data_a     ; read button position (should still be open)
                anda    #mask           ; is button still open (logical zero)
                beq     waitforopen     ;   no, wait until open

                bra     chkbutton       ; repeat loop

delay           ldd     #10             ; tune this to desired delay
innerdelay      subd    #1
                bne     innerdelay
                rts

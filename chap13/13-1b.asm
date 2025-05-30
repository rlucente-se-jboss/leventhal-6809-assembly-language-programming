; 13-1b. count pushbutton switch closures

; Count the number of button closures by incrementing memory location
; $40 after each closure. Button is connected to bit 0 of port A data
; register on 6821 PIA.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

pia_ctrl_a      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

mask            equ     %00000001
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
pushcount       fcb     $00

                org     $4000
                ldb     #$01            ; feature on 6809.uk emulator to set
                                        ; a memory address from register B
                                        ; when you left click to simulate a
                                        ; button depress

                clr     <pia_ctrl_a     ; address data direction register
                clr     <pia_ddr_a      ; make all data lines inputs
                lda     #%00000100      ; address data register
                sta     <pia_ctrl_a
                clr     <pushcount      ; count = zero initially
chkclo          lda     <pia_data_a
                anda    #mask           ; is button being pressed?
                bne     chkclo          ;    no, wait until it is
                inc     <pushcount      ;    yes, add 1 to closure count
                lda     #10             ; wait 10 ms to debounce button
                jsr     delay
chkopn          lda     <pia_data_a     ; is button still being pressed?
                anda    #mask
                beq     chkopn          ;    yes, wait for release
                bra     chkclo          ;    no, look for next closure

; 13-3a. turn the light on or off (send a logic one to the led)

; The program turns a single LED either on or off. Send a logic one
; to the LED (light a display that operates in positive logic or turn
; off a display that operates in negative logic).

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; port B of PIA is at addresses $22/$23 and port A is at addresses
; $20/$21

pia_ctrl_b      equ     $23             ; PIA port B control register
pia_ddr_b       equ     $22             ; PIA port B data direction register
pia_data_b      equ     $22             ; PIA port B data register
maskp           equ     %10000000       ; the LED position mask for the PIA


                org     $4000
start           clr     <pia_ctrl_b     ; address data direction register
                lda     #$ff            ; make all data lines outputs
                sta     <pia_ddr_b
                lda     #%00000100      ; address data register
                sta     <pia_ctrl_b

; form data initially which enables the LED but turns off everything
; else
                lda     #maskp          ; get data for LED
                sta     <pia_data_b     ; send data to LED

; turn off the LED after a short delay

                bsr     shortdelay

                lda     #maskp          ; get complement of LED mask
                coma
                anda    <pia_data_b     ; mask off the LED bit
                sta     <pia_data_b

; turn on the LED after a short delay

                bsr     shortdelay

                lda     <pia_data_b     ; get old data
                ora     #maskp          ; set LED output bit to 1
                sta     <pia_data_b

                rts

shortdelay      ldx     #100
delay           leax    -1,x
                bne     delay
                rts

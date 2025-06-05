; 13-5b. identify key (and rescan if none found)

; Identify a key closure by placing the number of the key in
; accumulator B. The procedure is as follows:

; 1. Set key number to 1, keyboard output port to all ones except
;    for a zero in bit 0, and row counter to number of rows
; 2. Fetch the column inputs by reading the input port
; 3. If any column inputs are zero, proceed to step 7
; 4. Add the number of colums to the key number to reach next row
; 5. Update the contents of the output port shifting the zero bit
;    left one position
; 6. Decrement row counter. Go to step 2 if any rows have not been
;    scanned; otherwise, go to step 9
; 7. Add 1 to key number. Shift column inputs right one bit
; 8. If carry=1, return to step 7
; 9. End of program

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; port B of PIA is at addresses $22/$23 and port A is at addresses
; $20/$21

pia_ctrl_a      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

pia_ctrl_b      equ     $23             ; PIA port B control register
pia_ddr_b       equ     $22             ; PIA port B data direction register
pia_data_b      equ     $22             ; PIA port B data register

                org     $40
counter         fcb     1

                org     $4000
start           clr     <pia_ctrl_a     ; address data direction registers
                clr     <pia_ctrl_b
                clr     <pia_ddr_a      ; make A side data lines inputs
                lda     #$ff            ; make B side data lines outputs
                sta     <pia_ddr_b
                lda     #%00000100      ; address data registers
                sta     <pia_ctrl_a
                sta     <pia_ctrl_b

scan            lda     #%11111110      ; start by grounding row zero
                sta     <pia_data_b
                lda     #3              ; counter = number of rows
                sta     <counter
                ldb     #$ff            ; key number = -1

frow            lda     <pia_data_a     ; get column inputs
                anda    #%00000111      ; mask off column bits
                cmpa    #%00000111      ; are any keys closed in this row?
                bne     fcol            ;   yes, determine which one
                addb    #3              ;   no, proceed to next row
                asl     <pia_data_b     ; update scan pattern
                dec     <counter        ; continue if any rows not scanned
                bne     frow
                bra     scan            ; no key found, so rescan

fcol            incb                    ; key number = key number + 1
                lsra                    ; is this column grounded?
                bcs     fcol            ;   no, examine next column
                rts                     ; yes, key closure identified

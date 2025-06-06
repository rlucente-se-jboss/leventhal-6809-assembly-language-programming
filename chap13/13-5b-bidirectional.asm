; 13-5b. identify key (using bidirectional feature of PIA)

; Identify a key closure by placing the number of the key in
; accumulator B. The procedure is as follows:

; 1. Ground all columns and save the row inputs
; 2. Ground all rows and save the column inputs
; 3. Use both the row and column inputs to determine the key number
;    from a table

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
keynum          rmb     1
keytable        fcc     '123456789'     ; characters mapped to keys
        
                org     $4000
start           clr     <pia_ctrl_a     ; address data direction registers
                clr     <pia_ctrl_b

                lda     #$ff            ; make A side data lines outputs (cols)
                sta     <pia_ddr_a
                clr     <pia_ddr_b      ; make B side data lines inputs (rows)

                lda     #%00000100      ; address data registers
                sta     <pia_ctrl_a
                sta     <pia_ctrl_b

getrow          clr     <pia_data_a     ; ground all columns
                ldb     <pia_data_b     ; read the rows
                andb    #%00000111      ; mask off all but three rows
                cmpb    #%00000111      ; check if any rows now grounded
                beq     getrow          ;   no, keep looking

                clr     <pia_ctrl_a     ; address data direction registers
                clr     <pia_ctrl_b

                clr     <pia_ddr_a      ; make A side data lines inputs (cols)
                lda     #$ff            ; make B side data lines outputs (rows)
                sta     <pia_ddr_b

                lda     #%00000100      ; address data registers
                sta     <pia_ctrl_a
                sta     <pia_ctrl_b

                clr     <pia_data_b     ; ground all rows
                lda     <pia_data_a     ; read the columns
                anda    #%00000111      ; mask off all but three columns

                comb                    ; row is 0, 1, 2
                asrb
                coma                    ; column is 0, 1, 2
                asra

                pshs    a               ; put columns on stack for later add
                lda     #3              ; get offset for row
                mul                     ; result is 0, 3, 6
                addb    ,s              ; add columns

                ldx     #keytable       ; index into key table for key number
                lda     b,x
                sta     <keynum
                puls    a,pc            ; correct stack and return

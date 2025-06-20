; Problem 13-3. control for a rotary switch

; Another switch serves as a Load switch for a four-position unencoded
; rotary switch. The CPU waits for the Load switch to close (be zero),
; and then reads the position of the rotary switch. This procedure
; allows the operator to move the rotary switch to its final position
; before the CPU tries to read it. The program should place the
; position of the rotary switch into memory location $40. Debounce
; the Load switch in software.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; Assume that the load switch is wired to bit 7 of the port A data
; register and that the four positions of the rotary switch are wired
; to bits 3-0 of the port A data register.

pia_ctrl_a      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

                org     $40
                setdp   0
switchposition  rmb     1
debouncedelay   fcb     $10             ; debounce delay in ms

                org     $4000

                clr     <pia_ctrl_a     ; address data direction register
                clr     <pia_ddr_a      ; make all data lines inputs
                lda     #%00000100      ; address data register
                sta     <pia_ctrl_a

chkload         lda     <pia_data_a     ; read button position
                bmi     chkload         ; wait until closed (bit 7 = 0)

                bsr     delay           ; small debounce delay to ensure closed

                lda     <pia_data_a     ; is switch still closed?
                bmi     chkload         ;   no, try again

                anda    #$0f            ; isolate the switch positions
                sta     switchposition  ; save current switch position

                bra     chkload

delay           ldx     <debouncedelay  ; number of ms to delay
outerdelay      ldd     #10             ; tune this to achieve 1 ms delay
innerdelay      subd    #1
                bne     innerdelay
                leax    -1,x
                bne     outerdelay
                rts

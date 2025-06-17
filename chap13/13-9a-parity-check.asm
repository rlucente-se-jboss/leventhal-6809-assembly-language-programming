; 13-9a. read data from a teletypewriter (TTY) with even parity check

; Fetch data from a teletypewriter using bit 7 of a PIA data port
; and place the data in memory location $60.

; Assume that the serial port is bit 7 of the PIA and that there
; is even parity. No framing check is necessary.

; NB: With the 6809.uk emulator, there is no 6821 PIA at address
;     $20 so this is more informational than anything else.

; port A is at addresses $20/$21

pia_ctrl_a      equ     $21             ; PIA port A control register
pia_ddr_a       equ     $20             ; PIA port A data direction register
pia_data_a      equ     $20             ; PIA port A data register

                org     $60
data            rmb     1               ; data read from TTY
badparity       rmb     1

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

; parity check is clever as it on average only checks 7 bits of the
; data, with the loop consisting of nine clock cycles per bit
;
; data          values  iterations      total iterations
; xxxxxxx1      128     8               128*8 = 1024
; xxxxxx10       64     7                64*7 =  448
; xxxxx100       32     6                32*6 =  192
; xxxx1000       16     5                16*5 =   80
; xxx10000        8     4                 8*4 =   32
; xx100000        4     3                 4*3 =   12
; x1000000        2     2                 2*2 =    4
; 10000000        1     1                 1*1 =    1
; 00000000        1     1                 1*1 =    1
;
; total         256                             1794
;
; average iterations = 1794 / 256 = 7.0078125
; average cycles ~ 63

                clrb                    ; b is count of 1's for parity
                stb     <badparity
chbit           asla                    ; shift a data bit to carry
                adcb    #0              ; if bit is 1, add 1 to bit count
                tsta                    ; keep counting until data is zero
                bne     chbit

                andb    #1              ; check if parity is even
                beq     parityeven      ;   yes, exit
                stb     <badparity      ;   no, set flag for bad parity

parityeven      rts

dly2            ldx     #$0236          ; count for 4.55 ms
                bra     dly             ;   (clock rate = 1 MHz)
delay           ldx     #$046c          ; count for 9.1 ms
dly             leax    -1,x
                bne     dly
                rts

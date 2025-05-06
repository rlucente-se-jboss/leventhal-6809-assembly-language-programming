; 11-1a. length of a string of characters

; Determine the length of a string of ASCII characters. The terminating
; character and the starting address of the string follow the subroutine
; call. The length of the string (excluding the terminating character)
; is returned in Accumulator B. No other registers are affected.

ASC_CR          equ     $0d

                org     $4000
                setdp   0

                jsr     stlen           ; determine string length
                fcb     ASC_CR          ; string terminator
                fdb     pointer         ; starting address of string
                stb     <result         ; save string length

                lda     #ASC_CR         ; set up next example
                sta     <pointer

                jsr     stlen           ; determine string length
                fcb     ASC_CR          ; string terminator
                fdb     pointer         ; starting address of string
                stb     <result         ; save string length

                rts

* subroutine stlen
*
* purpose: stlen determines the length of a string (number of
*   characters preceding a terminator)
*
* initial conditions: terminator in byte immediately following
*   subroutine call, starting address of string in next two bytes (msb's
*   in first byte)
*
* final conditions: number of characters in B
*
* registers affected: B
*
* sample case:
*   initial conditions: terminator = $0d, starting address = $0042,
*   ($42) = $4d, ($43) = $41, ($44) = $4e, ($45) = $0d
*   final conditions: (B) = $03
*
* typical call:
*               jsr     stlen
*               fcb     term            ; terminator
*               fdb     start           ; starting address of string
                
                org     $20
stlen           pshs    u,x,a,cc        ; save registers
                ldu     6,s             ; access paramter list
                pulu    a,x             ; get string terminator, start address
                ldb     #$ff            ; start B at -1
chktrm          incb                    ; add 1 to string length
                cmpa    ,x+             ; is next character a terminator?
                bne     chktrm          ;   no, keep looking
                stu     6,s             ; move return address past param list
                puls    pc,u,x,a,cc     ; restore registers and return

                org     $42
result          fcb     $00
pointer         fcc     'rather'
                fcb     ASC_CR

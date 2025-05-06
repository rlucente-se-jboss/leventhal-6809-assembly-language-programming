; 11-1b. length of a string of characters

; Determine the length of a string of ASCII characters. The starting
; address of the string and the terminating character are placed in
; the Hardware Stack. The length of the string (excluding the terminating
; character) is returned at the top of the Hardware Stack. No registers
; are affected.

ASC_CR          equ     $0d

                org     $4000
                setdp   0

                leas    -1,s            ; leave room for length of string
                lda     #ASC_CR         ; get terminator
                ldx     #pointer        ; get starting address of string
                pshs    a,x             ; save parameters in hardware stack
                jsr     stlen           ; determine string length
                leas    3,s             ; remove parameters from stack
                puls    a               ; get string length from stack
                sta     <result         ; save string length

                lda     #ASC_CR         ; set up next example
                sta     <pointer

                leas    -1,s            ; leave room for length of string
                lda     #ASC_CR         ; get terminator
                ldx     #pointer        ; get starting address of string
                pshs    a,x             ; save parameters in hardware stack
                jsr     stlen           ; determine string length
                leas    3,s             ; remove parameters from stack
                puls    a               ; get string length from stack
                sta     <result         ; save string length

                rts

* subroutine stlen
*
* purpose: stlen determines the length of a string (number of
*   characters preceding a terminator)
*
* initial conditions: terminator on top of stack, followed by
*   starting addresss of string and an empty byte for the string length
*
* final conditions: string length on stack under parameters
*
* registers affected: none
*
* sample case:
*   initial conditions: terminator = $0d, starting address = $0042,
*   ($42) = $4d, ($43) = $41, ($44) = $4e, ($45) = $0d
*   final conditions: string length = $03
*
* typical call:
*               leas    -1,s    ; leave empty byte for length of string
*               lda     #term   ; string terminator
*               ldx     #start  ; startin address of string
*               pshs    a,x     ; save parameters in stack
*               jsr     stlen   ; determine string length
                
                org     $20
stlen           pshs    u,x,b,a,cc      ; save registers
                leau    9,s             ; access parameter list in stack
                pulu    a,x             ; get string terminator, staring address
                ldb     #$ff            ; string length = -1
chktrm          incb                    ; add 1 to string length
                cmpa    ,x+             ; is next character a terminator?
                bne     chktrm          ;   no, keep looking
                stb     ,u              ; save string length in stack
                puls    pc,x,u,b,a,cc   ; restore registers and return

                org     $42
result          fcb     $00
pointer         fcc     'rather'
                fcb     ASC_CR

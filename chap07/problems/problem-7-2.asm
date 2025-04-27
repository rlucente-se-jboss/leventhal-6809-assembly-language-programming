; Problem 7-2. seven-segment to decimal

; Convert the contents of memory location $40 from a seven-segment
; code to a decimal number in memory location $41. If memory location
; $40 does not contain a valid seven-segment code, set memory location
; $41 to $ff. Use the seven-segment table given in 7-1 and try to
; match codes.

        org     $4000
        setdp   0

        bsr     seven

        lda     #$28
        sta     data
        clr     result

seven   lda     data
        ldx     #sseg
        ldb     #ssegend-sseg-1
comp    cmpa    b,x
        beq     done
        decb
        bpl     comp
done    stb     result
        rts

        org     $40
data    fcb     $4f
result  fcb     0

        org     $50
sseg    fcb     $3f,$06,$5b,$4f,$66
        fcb     $6d,$7d,$07,$7f,$6f
ssegend rmb     0

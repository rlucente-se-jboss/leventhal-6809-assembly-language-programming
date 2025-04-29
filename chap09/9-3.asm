; 9-3. remove element from queue

; Memory locations $42 and $43 contain the address of the head of
; the queue (MSBs in $42). Place the address of the first element
; (head) of a queue into memory locations $40 and $41 (MSBs in $40)
; and update the queue to remove the element. Each element in the
; queue is two bytes long and contains the address of the next two-byte
; element in the queue. The last element in the queue contains zero
; to indicate that there is no next element.

                org     $4000
                setdp   0

                bsr     deletehead

                ldd     #0              ; set up next example
                std     <pointer        ; empty queue

                coma
                comb
                std     <removed

deletehead      ldx     <pointer        ; get address of head of queue
                stx     <removed        ; remove head of queue
                beq     done            ; done if queue was empty
                ldx     ,x              ; get address from next element
                stx     <pointer        ; move next element to head of queue
done            rts

                org     $40
removed         fdb     $ffff
pointer         fdb     $0046
                fdb     $ffff
                fdb     $004d
                fdb     $ffff
                fdb     $ffff
                fcb     $00             ; weird byte offset
                fdb     $0000           ; 0 marks end of queue

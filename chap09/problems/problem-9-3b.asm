; 9-3b. add element to queue with tail pointer

; Add the address in memory locations $40 and $41 (MSBs in $40) to
; a queue. The address of the first element of the queue is in memory
; locations $42 and $43 (MSBs in $42). The address of the tail of
; the queue is in memory locations $44 and $45 (MSBs in $44). Each
; element in the queue contains either the address of the next element
; in the queue or zero if there is no next element; all addresses are
; 16 bits long with the most significant bits in the first byte of
; the element. The new element goes at the end (tail) of the queue;
; its address will be in the element that was at the end of the queue
; and it will contain zero to indicate that it is now the end of the
; queue.

                org     $4000
                setdp   0

addentry        ldx     <tail
                ldd     <entry
                std     ,x
                ldd     #0
                std     [,x]
                rts

                org     $40
entry           fdb     $004d           ; $0040
queue           fdb     $0046           ; $0042
tail            fdb     $0046           ; $0044
                fdb     $0000           ; $0046 
                fdb     $ffff           ; $0048
                fdb     $ffff           ; $004a
                fcb     $ff             ; $004c, but weird
                fdb     $ffff           ; $004d

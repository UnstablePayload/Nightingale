; Nightingale - Fantasy Adventure for Atari 2600
; Author: Tyler Taylor
; https://github.com/TylerOliverTaylor/Nightingale
; README.md file contains game description and build information.
; Assemble in MADS: mads -l -t nightingale.asm

    org $2000           ; Start of program in memory

SAVMSC = $0058          ; Screen memory address
SDLSTL = $0230          ; Display list starting address

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
screen = $4000          ; Screen buffer
blank8 = $70            ; 8 blank lines
antic5 = 5              ; ANTIC mode 5
lms = $40               ; Load Memory Scan
jvb = $40               ; Jump while vertical blank


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Load Display List
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #<dlist         
    sta SDLSTL
    lda #>dlist
    sta SDLSTL+1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   MAIN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ldy #0              ; Loads y with "0" this will allow indirect addressing mode in line 14 
loop
    lda hello,y         ; Loads the a register
    sta screen,y        ; Stores into screen memory
    iny                 ; Increment y by 1
    cpy #12             ; Compairs y to 12, represents the 12 characters in hello, if != 12 loops back else break loop
    bne loop           

    jmp *               ; * means jump to self...this keeps the processor busy...basically 6502 version of "GOTO"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Display List
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dlist
    .byte blank8, blank8, blank8
    .byte antic5 + lms, <screen , >screen
    .byte antic5, antic5, antic5, antic5, antic5, antic5
    .byte antic5, antic5, antic5, antic5, antic5
    .byte jvb, <dlist, >dlist

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   DATA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hello
    .byte "HELLO ATARI!"
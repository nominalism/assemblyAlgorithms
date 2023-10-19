; Include necessary header file
include 'emu8086.inc'

; Set program origin to address 100h
org 100h

; Define data section
.data
    array db 9,7,5,4,3,2,6  ; Define an array of bytes to be sorted
    count dw 7               ; Define a word variable to store the number of elements in the array

; Code section starts here
.code

; Bubble sort algorithm
    mov cx, count           ; Load count into CX register
    dec cx                  ; Decrement CX for outer loop iteration count

nextscan:                    ; Outer loop (do { )
    mov bx, cx              ; Copy current value of CX to BX for inner loop iteration count
    mov si, 0               ; Initialize SI register to 0 for array index

nextcomp:                    ; Inner loop (do { )
    mov al, array[si]       ; Load element at index SI into AL
    mov dl, array[si+1]     ; Load next element into DL
    cmp al, dl              ; Compare AL and DL

    jnc noswap              ; Jump to noswap label if AL >= DL

    ; Swap elements if they are in the wrong order
    mov array[si], dl       ; Move DL to current index
    mov array[si+1], al     ; Move AL to next index

noswap: 
    inc si                  ; Increment SI (move to the next element in the array)
    dec bx                  ; Decrement BX (decrement inner loop counter)
    jnz nextcomp            ; Jump to nextcomp if BX != 0 (continue inner loop)

    loop nextscan           ; Loop: decrement CX and jump to nextscan if CX != 0 (continue outer loop)

; Display sorted elements on the screen
    mov cx, 7               ; Load count of elements into CX
    mov si, 0               ; Initialize SI register to 0 for array index

print:
    mov al, array[si]       ; Load element at index SI into AL
    add al, 30h             ; Convert AL to ASCII character (add 30h)
    mov ah, 0eh             ; Set AH to 0eh for teletype output subfunction
    int 10h                 ; Call BIOS interrupt 10h to print the character in AL

    mov ah, 2               ; Set AH to 2 for DOS display character function
    mov dl, ' '             ; Load space character into DL
    int 21h                 ; Call DOS interrupt 21h to print space character

    inc si                  ; Increment SI (move to the next element in the array)
    loop print              ; Loop: decrement CX and jump to print if CX != 0 (continue displaying elements)

    ret                     ; Return from the program

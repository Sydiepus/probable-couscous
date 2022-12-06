global _start

section .data
    file: db  "input",0x00    ;filename
    buffer_len: equ 10000    ;size of buffer

section .bss
    buffer: resb 10000   ;file is 10000 bytes

section .text
    _start:
    
    ;open file
    mov eax, 0x05       ;syscall open
    mov ebx, file       ;file name
    mov ecx, 0x00       ; flags, idk set them to 0
    mov edx, 0x00       ; mode 0 read only
    int 0x80            ;call kernel ?
    
    ;read contents into buffer
    mov ebx, eax        ;read file descriptor
    mov eax, 0x03       ;syscall read
    mov ecx, buffer     ; read using buffer ?
    mov edx, buffer_len     ;buffer len
    int 0x80            ; call kernel 

    ;write buffer
    mov edx, eax        ; eax contains amount read
    mov eax, 0x04       ; syscall write
    mov ebx, 0x01       ; stdout
    mov ecx, buffer     ;write buffer
    int 0x80            ; call kernel

    ;close file
    mov eax, 0x06       ;syscall close
    int 0x80


    ;exit
    mov eax, 0x01       ; syscall exxit
    mov ebx, 0x00       ; error code 0
    int 0x80
    
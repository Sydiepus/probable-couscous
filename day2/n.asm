global _start

section .data
    file: db  "input",0x00    ;filename
    buffer: db 1   ;i'm gonna read file byte by byte
    buffer_len: equ 1    ;size of buffer
    ;offset: db 0
    ;msg: db  "Hello world",0xA
    ;msg_len: equ $-msg

section .bss

section .text
    _start:
        ;mov edi, 0x00
        ;call tlp
        call open_file
        mov ebp, 0         ;offset will be stored in ebp
        call lp
        ;jmp read_buf
        ;jmp write_stdout
        ;call close_file
        call exit
    
        ;exit
    exit:
        call close_file
        mov eax, 0x01       ; syscall exxit
        mov ebx, 0x00       ; error code 0
        int 0x80

    ;close file
    close_file:
        mov eax, 0x06       ;syscall close
        int 0x80
        ret

    ;open file
    open_file:
        mov eax, 0x05       ;syscall open
        mov ebx, file       ;file name
        mov ecx, 0x00       ; flags, idk set them to 0
        mov edx, 0x00       ; mode 0 read only
        int 0x80            ;call kernel ?
        mov edi, eax        ;backup file descriptor to edi
        ret

    ;read contents into buffer
    read_buf:
        mov ebx, edi        ;read file descriptor
        mov eax, 0x03       ;syscall read
        mov ecx, buffer     ; read using buffer ?
        mov edx, buffer_len     ;buffer len
        int 0x80            ; call kernel 
        ret

    ;write buffer
    write_stdout:
        mov edx, eax        ; eax contains amount read
        mov eax, 0x04       ; syscall write
        mov ebx, 0x01       ; stdout
        mov ecx, buffer     ;write buffer
        int 0x80            ; call kernel
        ret
    
    ;read loop
    lp:
        call read_buf
        mov cl, 0x0A           ; linux line feed 0x0A
        cmp [buffer], cl
        je exxit                ; if equal exit
        call write_stdout
        jne lp
        ;test eax, eax          ; this can be used to detect EOF
        ;jnz lp
        ;inc ebp
        ;call seek
        ;mov edx, 0x00
        ;cmp [buffer], edx       ;line feed on linux
        ;JE exit
        ;JNE lp
        ret

    ;seek
    ;when you read from file it always get 'seeked'
    ;seek:
    ;    mov ebx, edi        ; file descriptor is in edi
    ;    mov eax, 0x13       ; 13 lseek syscall
    ;    mov ecx, ebp         ; place offset in ecx
    ;    mov edx, 0x00       ; origin is begining of file
    ;    int 0x80
    ;    ret

    ; Loop example
    ;   mov edi, 0
    ;tlp:
    ;    inc edi
    ;    mov eax, 0x04       ;syscall write
    ;    mov ebx, 0x01       ;to stdout
    ;    mov ecx, msg        ; char buf to write
    ;    mov edx, msg_len    ; size
    ;    int 0x80            ;call kernel ?
    ;    cmp edi, 0x0A
    ;    jne tlp
    ;    ret
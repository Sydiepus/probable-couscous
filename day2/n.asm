global _start

section .data
    file: db  "input",0x00    ;filename
    buffer: db 1   ;i'm gonna read file byte by byte
    buffer_len: equ 1    ;size of buffer
    ;offset: db 0
    ;msg: db  "Hello world",0xA
    ;msg_len: equ $-msg
    ;score: db 0        ; set score to 0
    ;elf: db 1

section .bss
    score: resw 2
    elf: resb 1
    user: resb 1

section .text
    _start:
        ;mov edi, 0x00
        ;call tlp
        call open_file
        ;mov ebp, 0         ;offset will be stored in ebp
        call lp
        ;jmp read_buf
        ;jmp write_stdout
        ;call close_file
        ;call tpt
        call exit
    
    ;exit
    exit:
        call close_file
        mov eax, 0x01       ; syscall exit
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
        test eax, eax          ; this is used to detect EOF
        jz exit                 ; exit when EOF is reached
        ;mov cl, 0x0A           ; linux line feed 0x0A
        mov cl, " "
        cmp [buffer], cl
        je lp                ; if equal to " "/space skip it
        mov cl, 0x0A            ; new line we want to skip it
        cmp [buffer], cl
        je lp                   ; skip new line too
        mov cl, "A"             ; elf chose A : rock
        mov [elf], cl
        cmp [buffer], cl
        je check_draw
        mov cl, "B"             ; elf chose B : paper
        mov [elf], cl
        cmp [buffer], cl
        je check_draw
        mov cl, "C"             ; elf chose C : scissor
        mov [elf], cl
        cmp [buffer], cl
        je check_draw
        jmp lp
        ;test eax, eax          ; this can be used to detect EOF
        ;jnz lp
        ;inc ebp
        ;call seek
        ;mov edx, 0x00
        ;cmp [buffer], edx       ;line feed on linux
        ;JE exit
        ;JNE lp

    ; dl user choice cl elf choice.
    check_draw:
        call read_buf           ;Since it's the first column we call read twice to get to the second
        call read_buf
        mov dl, [buffer]
        sub dl, 23              ; poss val are X,Y,Z which become A,B,C respectively after subtracting by 23
        mov cl, [elf]
        mov [user], dl
        cmp dl, cl              ; if equal then it's a draw
        je draw
        jne check_win

    draw:
        mov al, [user]
        sub al, 64              ; amount of points to be given base on choice is 1,2,3 for A,B,C
        mov dx, [score]
        add dx, 3              ; add 3 points because it's a draw
        cbw                     ; convert al register to ax
        add dx, ax             ; add choice points
        mov [score], dx
        jmp lp

    check_win:
        mov bl, [elf]   
        mov dl, [user]           
        add bl, 1               ; if user choice is for EX B after sub 23 of course
        cmp bl, dl              ; and it's a not  draw, then we add 1 tp elf choice if by doing so it becomes = to 
        je win                  ; user choice then it's a win to the user.
        cmp bl, 68
        jge edge
        ;loss        
        mov al, [user]
        sub al, 64              ; amount of points to be given base on choice is 1,2,3 for A,B,C
        mov dx, [score]
        cbw                     ; convert al register to ax
        add dx, ax             ; add choice points
        mov [score], dx

    win:
        mov al, [user]
        sub al, 64              ; amount of points to be given base on choice is 1,2,3 for A,B,C
        mov dx, [score]
        add dx, 6              ; add 6 points because it's a win
        cbw                     ; convert al register to ax
        add dx, ax             ; add choice points
        mov [score], dx
        jmp lp
    
    edge:                   ;since  we've passed our choices we will go back to the first choice A
        mov dl, [user]
        cmp dl, 65          ; this occurs when C is the elf choice we check make bl/cl 65 and check for win.
        je win
        mov al, dl
        sub al, 64              ; amount of points to be given base on choice is 1,2,3 for A,B,C
        mov dx, [score]
        cbw                     ; convert al register to ax
        add dx, ax             ; add choice points
        mov [score], dx
        jmp lp

    ; 0 = 48
    ; add numbers
    ; number need to be converted to ascii to be written.
    ;tpt:
    ;    mov dx, [score]
    ;    add dx, 1
    ;    mov [score], dx
    ;    mov eax, 0x04       ;syscall write
    ;    mov ebx, 0x01       ;to stdout
    ;    mov ecx, score        ; char buf to write
    ;    mov edx, 0x01    ; size
    ;    int 0x80
    ;    ret

    ;seek
    ;when you read from file it always get 'seeked', haha very funny.
    ;seek:
    ;    mov ebx, edi        ; file descriptor is in edi
    ;    mov eax, 0x13       ; 13 lseek syscall
    ;    mov ecx, ebp         ; place offset in ecx
    ;    mov edx, 0x00       ; origin is beginning of file
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
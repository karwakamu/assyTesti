STD_OUTPUT_HANDLE   equ -11
STD_INPUT_HANDLE    equ -10
NULL equ 0

global  WinMain
extern  GetStdHandle
extern  WriteFile
extern  ReadConsoleInputA
extern  MessageBoxA
extern  ExitProcess

section .text

func:
    push    ebp 
    mov     ebp,esp 
    sub     esp, 4
    
    push    STD_OUTPUT_HANDLE
    call    GetStdHandle

    push    0
    lea     ebx, [ebp-4]
    push    ebx
    push    1
    lea     ebx, [ebp+8]
    push    ebx
    push    eax
    call    WriteFile

    leave
    ret

popup:
    push    ebp 
    mov     ebp,esp 

    mov     eax,[ebp+8]
    mov     ebx,[ebp+12]
    OR      eax,ebx

    push    eax         ; uType = MB_OK
    push    title ; LPCSTR lpCaption
    lea     eax, [ebp+16]
    push    eax   ; LPCSTR lpText
    push    0            ; hWnd = HWND_DESKTOP
    call    MessageBoxA
    push    eax          ; uExitCode = MessageBox(...)

    leave
    ret

WinMain:

loop:
    mov eax, 5
    add eax, '0'
    push eax
    call func

    
    mov eax, 5
    add eax, '0'
    push eax
    push 48
    push 4
    call popup

    jmp end
    cmp eax, 7
    je end
    jmp loop

end:
    call ExitProcess

    hlt     ; never here

section .data 
title:  db 'Hello world!', 0

section .bss
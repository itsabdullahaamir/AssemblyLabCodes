.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, a:dword
GetStdHandle proto, a1:dword
ReadConsoleA proto, a1:dword, a2:ptr byte, a3:dword, a4: ptr dword, a5:dword
WriteConsoleA proto, a1:dword, a2:ptr byte, a3:dword, a4: ptr dword, a5:dword

STD_IN_HANDLE EQU -10
STD_OUT_HANDLE EQU -11

.data
    hStdIn dword ?
    hStdOut dword ?

    inputVal db 100 DUP(?)
    inputCount dd ?

    fixedVal db 100 DUP (0)
    outputCount dd ?

    nextLine db 13,10,0
.code
main proc
    INVOKE GetStdHandle, STD_IN_HANDLE
    mov hStdIn, eax

    INVOKE GetStdHandle, STD_OUT_HANDLE
    mov hStdOut, eax

    INVOKE ReadConsoleA, hStdIn, OFFSET inputVal, 100, OFFSET inputCount, 0
    
    ; remove CRLF
    mov eax, inputCount
    sub eax, 2
    mov inputCount, eax

    mov ebx, 0        ; input index
    mov ecx, 0        ; output index (stack top)

charLoop:
    cmp ebx, inputCount
    jge done

    mov dl, inputVal[ebx]   ; current char
    inc ebx

    cmp ecx, 0
    je pushChar             ; if stack empty, push

    ; Compare with top of stack
    mov al, fixedVal[ecx-1]
    cmp al, dl
    je charLoop             ; skip duplicate

pushChar:
    PUSH edx                ; simulate stack push (optional)
    POP edx
    mov fixedVal[ecx], dl
    inc ecx
    jmp charLoop

done:
    INVOKE WriteConsoleA, hStdOut, OFFSET fixedVal, ecx, OFFSET outputCount, 0
    INVOKE WriteConsoleA, hStdOut, OFFSET nextLine, 2, OFFSET outputCount, 0

    INVOKE ExitProcess, 0
main endp
end main

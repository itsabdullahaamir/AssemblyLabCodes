.386
.model flat, stdcall
.stack 4096
.data

ExitProcess PROTO , a:dword
    valuesCheck db 65000 DUP(0)
    
.code
main proc

    mov ebx, 2
    mov ecx, 2
    fixLoop:
        cmp ebx, 65000
        je done
        cmp valuesCheck[ebx], 0
        je removeMuls
    returnFromRemoveMuls:
        inc ebx
        jmp fixLoop

    removeMuls:
        mov ecx, ebx
    nextStep:
        add ecx, ebx
                cmp ecx, 65000
        jge returnFromRemoveMuls
        mov valuesCheck[ecx], 1
        jmp nextStep
        done:

    INVOKE ExitProcess, 0
main endp
end main

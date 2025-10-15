INCLUDE Irvine32.inc      ; Include the Irvine32 library

ExitProcess PROTO dwExitCode:DWORD
GetStdHandle proto, a1:dword
ReadConsoleA proto, a1:dword, a2:ptr byte, a3:dword, a4: ptr dword, a5:dword
WriteConsoleA proto, a1:dword, a2:ptr byte, a3:dword, a4: ptr dword, a5:dword

STD_OUTPUT_HANDLE equ -11
STD_INPUT_HANDLE  equ -10

COMMENT ?
Write an assembly program to check if a string of parentheses is balanced using a stack. For each opening parenthesis (, push it onto the stack, and for each closing parenthesis ), pop from the stack and check if it matches.
?

.data
    inStdHandle dd ?
    outStdHandle dd ?

    prompt BYTE "Enter a string of parentheses: ", 0

    inputVals BYTE 100 DUP(0)

    valsInput dd ?
    valsOutput dd ?

    balancedMsg BYTE "The parentheses are balanced.", 0
    notBalancedMsg BYTE "The parentheses are not balanced.", 0
.code
main PROC
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outStdHandle, eax

    INVOKE GetStdHandle, STD_INPUT_HANDLE
    mov inStdHandle, eax

    INVOKE WriteConsoleA, outStdHandle, OFFSET prompt, LENGTHOF prompt - 1, valsOutput, 0

    INVOKE ReadConsoleA, inStdHandle, OFFSET inputVals, 100, OFFSET valsInput, 0

    mov eax, valsInput
    sub eax, 2
    mov valsInput, eax

    mov ecx, valsInput
    mov ebx, 0          ; Initialize index for input string
    mov esi, 0          ; Stack pointer (number of '(' on stack)

    pushPopLoop:
        cmp ebx, ecx
        jge checkStack

        mov al, inputVals[ebx]
        cmp al, '('
        je pushOp
        cmp al, ')'
        je popOp
        jmp continueLoop

        pushOp:
            inc esi
            jmp continueLoop

        popOp:
            cmp esi, 0
            je notBalanced
            dec esi
            jmp continueLoop

        continueLoop:
            inc ebx
            jmp pushPopLoop

    checkStack:
        cmp esi, 0
        je balanced
        jmp notBalanced

    balanced:
        INVOKE WriteConsoleA, outStdHandle, OFFSET balancedMsg, LENGTHOF balancedMsg - 1, valsOutput, 0
        jmp endProgram

    notBalanced:
         INVOKE WriteConsoleA, outStdHandle, OFFSET notBalancedMsg, LENGTHOF notBalancedMsg - 1, valsOutput, 0
         jmp endProgram

    endProgram:
main ENDP



INVOKE ExitProcess, 0          ; Exit the program with a return code of 0
END main                   			 ; End of the program

INCLUDE Irvine32.inc      ; Include the Irvine32 library

ExitProcess PROTO dwExitCode:DWORD

COMMENT ?
Write an assembly program to check whether a given string is a palindrome. Use the stack to reverse the string and compare it with the original
?

.data
 
    inputStr db 100 DUP(?)
    outputMessage db "Enter the string here : ",0
    numOfValsRead dd ?
    msgYes db "The string is a palindrome",0
    msgNo db "The string is not a palindrome",0

.code
main PROC
    
    mov edx, OFFSET outputMessage
    call WriteString             
    mov edx, OFFSET inputStr     
    mov ecx, 100                 
    call ReadString 
    mov numOfValsRead, eax

    ; Remove newline if present
    mov ecx, numOfValsRead
    cmp ecx, 0
    je skipNewline
    mov ebx, ecx
    dec ebx
    mov al, inputStr[ebx]
    cmp al, 0Dh
    jne skipNewline
    dec numOfValsRead

skipNewline:

    mov ecx, numOfValsRead
    mov ebx, 0
pushAll:
    mov al, inputStr[ebx]
    push eax
    inc ebx
    loop pushAll

    mov ecx, numOfValsRead
    mov ebx, 0
    mov esi, 0

compareLoop:
    pop eax
    mov dl, inputStr[ebx]
    cmp dl, al
    jne notPalindrome
    inc ebx
    loop compareLoop
    jmp isPalindrome

notPalindrome:
    mov esi, 1

isPalindrome:
    cmp esi, 0
    jne printNot
    mov edx, OFFSET msgYes
    call WriteString
    jmp done

printNot:
    mov edx, OFFSET msgNo
    call WriteString

done:
    call CrLf  

main ENDP

INVOKE ExitProcess, 0          ; Exit the program with a return code of 0
END main                   			 ; End of the program

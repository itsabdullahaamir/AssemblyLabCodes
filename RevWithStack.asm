INCLUDE Irvine32.inc      ; Include the Irvine32 library

ExitProcess PROTO dwExitCode:DWORD

COMMENT ?
Reversing an Array using Stack
Problem Statement: Write an assembly program to reverse an array of integers using stack operations. Push each element of the array onto the stack and then pop them in reverse order.
?

.data
    intArray DD 3,5,7,9,11          ; Define an array of integers

.code
main PROC
    mov ecx, LENGTHOF intArray  ; To run for the whole array
    mov esi, OFFSET intArray   ; Load the address of the array into ESI
    mov ebx, ecx          ; Copy the length of the array into EBI for popping later
    dec ebx               ; Decrement EBI to use as an index (0-based)
    pushIn:
        PUSH [esi + 4*ebx] ; Push each element onto the stack
        dec ebx            ; Decrement EBI to move to the previous element
    loop pushIn              ; Loop until all elements are pushed

    mov ecx, LENGTHOF intArray  ; Reset ECX to the length of the array for popping
    popOut:
        POP [esi + 4*ecx - 4]  ; Pop each element from the stack back into the array in reverse order
    loop popOut              ; Loop until all elements are popped

main ENDP

INVOKE ExitProcess, 0          ; Exit the program with a return code of 0
END main                   			 ; End of the program

;Write Assembly program to input letter from the user and display the previous character -- ASSUMING ALL VALID INPUT

.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitProcess : DWORD
GetStdHandle PROTO, nStdHandle:DWORD ; Get device handle
WriteConsoleA PROTO, a1:DWORD, a2:PTR BYTE, a3:DWORD, a4:PTR DWORD,a5:DWORD ; Output
ReadConsoleA PROTO, a1:DWORD, a2:PTR BYTE, a3:DWORD, a4:PTR DWORD, a5:DWORD; Input

STD_INPUT_HANDLE EQU -10
STD_OUTPUT_HANDLE EQU -11

.data
	
	hStdIn dword ?
	hStdOut dword ?

	outputMessage db "Input the character here: ",0
	bytesRead dword ?

	inCharacter db 3 DUP (?)
	inputSizeAllow dword 3
	inputSize dword ?

	endLineMessage db 10,13,0

.code
main proc
	
	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov hStdIn, eax

	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov hStdOut, eax

	INVOKE WriteConsoleA, hStdOut, OFFSET outputMessage, LENGTHOF outputMessage, OFFSET bytesRead,0
	INVOKE ReadConsoleA, hStdIn, OFFSET inCharacter, inputSizeAllow, OFFSET inputSize, 0
	
	mov eax, inputSize
	sub inputSize, 2
	mov inputSize, eax

	mov al, inCharacter
	dec al
	mov inCharacter, al

	INVOKE WriteConsoleA, hStdOut, OFFSET inCharacter, LENGTHOF inputSizeAllow, OFFSET bytesRead,0
	INVOKE WriteConsoleA, hStdOut, OFFSET endLineMessage, 2, OFFSET bytesRead,0




	INVOKE ExitProcess,0
main endp
end main

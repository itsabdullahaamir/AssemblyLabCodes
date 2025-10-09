; Write Assembly program to Input upper case letter from user and display lowercase.

.386
.model flat, stdcall
.stack 4096

GetStdHandle PROTO, nStdHandle:DWORD ; Get device handle
WriteConsoleA PROTO, a1:DWORD, a2:PTR BYTE, a3:DWORD, a4:PTR DWORD,a5:DWORD ; Output
ReadConsoleA PROTO, a1:DWORD, a2:PTR BYTE, a3:DWORD, a4:PTR DWORD, a5:DWORD; Input
ExitProcess proto, dwExitCode : DWORD

STD_INPUT_HANDLE EQU -10
STD_OUTPUT_HANDLE EQU -11

.data
	hSTDIn DWORD ?
	hSTDOut DWORD ?

	outMessageOne db "Enter the upper case letter here :",0
	wordIn db ?

	inChar db 3 DUP(?)
	inMessageSize dword 3
	inMessageGiven dword ?
	bytesRead dword ?

	endLineMessage db 10,13,0

.code
main proc
	
	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov hStdIn, eax

	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov hStdOut, eax

	INVOKE WriteConsoleA, hSTDOut, OFFSET outMessageOne, LENGTHOF outMessageOne, OFFSET bytesRead, 0

	INVOKE ReadConsoleA, hSTDIn, OFFSET inChar, inMessageSize , OFFSET inMessageGiven, 0
	mov eax, inMessageGiven
	sub inMessageGiven, 2
	mov inMessageGiven, eax
	
	mov eax,0
	mov al,inChar
	add eax, 32
	mov inChar, al

	INVOKE WriteConsoleA, hSTDOut, OFFSET inChar, inMessageGiven, OFFSET bytesRead, 0
	INVOKE WriteConsoleA, hSTDOut, OFFSET endLineMessage, 2, OFFSET bytesRead, 0
	

	INVOKE ExitProcess, 0
main endp
end main

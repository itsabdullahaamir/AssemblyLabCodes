;Write an assembly program that takes an input and tells whether the given number is even or odd

.386
.model flat, stdcall
.stack 4096

GetStdHandle PROTO, nStdHandle:DWORD ; Get device handle
WriteConsoleA PROTO, a1:DWORD, a2:PTR BYTE, a3:DWORD, a4:PTR DWORD,a5:DWORD ; Output
ReadConsoleA PROTO, a1:DWORD, a2:PTR BYTE, a3:DWORD, a4:PTR DWORD, a5:DWORD; Input
ExitProcess PROTO, dwExitCode : DWORD

STD_INPUT_HANDLE EQU -10
STD_OUTPUT_HANDLE EQU -11

.data
	hStdIn DWORD ?
	hStdOut DWORD ?

	OutputMessage db "Enter the number here (max 10 digits):",0

	bytesRead dword ?

	inputNumber db 12 dup (?)
	readSizeAllow dword 12
	readSize dword ?

	evenMessage db "Value is even",0
	oddMessage db "Value is odd" , 0
	newLineMessage db 10,13,0

.code
main proc

	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov hStdIn, eax

	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov hStdOut, eax

	INVOKE WriteConsoleA, hStdOut, OFFSET OutputMessage, LENGTHOF OutputMessage, OFFSET bytesRead, 0
	INVOKE ReadConsoleA, hStdIn, OFFSET inputNumber, readSizeAllow, OFFSET readSize, 0

	mov eax, readSize
	sub eax, 2
	mov readSize, eax

	mov edi, OFFSET inputNumber
	mov al, [edi + eax - 1]

	cmp al, 48
	je evenRun
	cmp al, 50
	je evenRun
	cmp al, 52
	je evenRun
	cmp al, 54
	je evenRun
	cmp al, 56
	je evenRun

	jmp oddRun

	evenRun:
		INVOKE WriteConsoleA, hStdOut, OFFSET evenMessage, LENGTHOF evenMessage, OFFSET bytesRead, 0
		INVOKE WriteConsoleA, hStdOut, OFFSET newLineMessage, 2, OFFSET bytesRead, 0
		jmp endCode

	oddRun:
		INVOKE WriteConsoleA, hStdOut, OFFSET oddMessage, LENGTHOF oddMessage, OFFSET bytesRead, 0
		INVOKE WriteConsoleA, hStdOut, OFFSET newLineMessage, 2, OFFSET bytesRead, 0

	endCode:


	INVOKE ExitProcess,0
main endp
end main

TITLE 2D array addressing
INCLUDE Irvine32.inc

.data
	mCalculating BYTE "Calculating..",0dh,0ah,0
	mAccessElement BYTE "The value of the element a[2,2] is : ",0
	mResultSum BYTE "The sum a[2,2] + z = :",0
	mResultDiff BYTE "The sum a[2,2] - z = :",0
	array SDWORD 00d,10d,20d,30d ;Signed 32bit 1D array
	ElementsPerRow =($-array)/TYPE array ;Calculating how many elements are in the array
		  SDWORD 01d,11d,21d,31d
		  SDWORD 02d,12d,22d,32d
		  SDWORD 03d,13d,23d,33d
	x BYTE 2d ;Array row index
	y BYTE 2d ;Array Col index
	z SWORD -30d
.code
main PROC
	;Askisi 1
	mov edx , OFFSET mCalculating ;Load EDX with the mCalculating string OFFSET
	call WriteString ;Show the message on screen

	;Calculating address of array1(2,2)
	;The result will be 32bit hense the arithmetic operations
	;are performed on 32bit registers

	;Move row to EBX register
	movzx ebx,x ;Converts 8bit variable to 32bit.The rest binary numbers are filled with zeroes
	shl ebx,2 ;EBX=row*4 (bitwise shift operation 2 times)

	;Move row to ECX register
	movzx ecx,y ;Converts 8bit variable to 32bit.The rest binary numbers are filled with zeroes
	add ebx,ecx ;EBX=row * 4 + column
	shl ebx,2   ;EBX=(row * 4 + column) * 4
	
	mov eax,[array1+ebx] ;mov designated array element to ECX using INDIRECT ADDRESSING
	;EAX is used later for the command WriteInt
	mov edx , OFFSET mAccessElement ;Load EDX with the mAccessElement string OFFSET
	call WriteString ;Show the message on the screen
	call WriteInt ;Show the element value on the screen
	call Crlf ;Go to next line

	movsx ecx,z ;move the value of z into ECX
	add eax,ecx	;EAX = 22 + ECX = -8
	mov edx,OFFSET mResultSum ;Load EDX with the mResultSum string OFFSET
	call WriteString ;Show the message on sceen
	call WriteInt ;Show the element value on sceen
	call Crlf ;Go to next line

	mov eax,[array1+ebx] ;move the value of z into EBX
	sub eax,ECX ;EAX = 22 - ECX = 52
	mov edx,OFFSET mResultDiff ;Load EDX with the mResultSum string OFFSET
	call WriteString ;Show the message on screen
	call WriteInt ;Show the element value on sceen
	call Crlf ;Go to next line

	exit
main ENDP
END main
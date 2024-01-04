    DIM EQU 100
    CESARKEY EQU 10 ; key for encoding/decoding in [0,52]

.MODEL small
.STACK       
.DATA
    line DB DIM DUP('_')
     
.CODE
.STARTUP       


; 1- TAKING IN INPUT THE LINE
  
    	XOR DI, DI  ; counter
    	MOV AH, 1   ; reading setting

lab    	INT 21H     ; read a char, put in AL
	MOV line[DI], AL
        INC DI
        
        CMP AL, 13  ; jump if ENTER (10 = LF)
        JE exit

        CMP CX, DIM   ; the 100th char has
        JNZ lab    ; been inserted
exit: 


	XOR DI, DI

pcesar:	MOV AH, 2	 ; print setup
	MOV DL, line[DI] ; char to print
	
	CMP DL, 13
	JZ exitcesar
	
	INC DI

	CMP DL, 91
	JB ck1

	ADD DL, CESARKEY
	CMP DL, 123
	JB print

	SUB DL, 58
	CMP DL, 91
	JB print
	ADD DL, 6
	J print	

ck1:	ADD DL, CESARKEY
	CMP DL, 91 
	JB print
	ADD DL, 6
	
	CMP DL, 123
	JB print
	SUB DL, 58

print:	INT 21h		 ; encoded char
	J pcesar
	

exitcesar:

.EXIT
END
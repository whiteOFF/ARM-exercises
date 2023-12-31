    DIM EQU 50
    MIN EQU 20
    CHARS EQU 52
    underline EQU "_"

.MODEL small
.STACK       
.DATA
    line DB DIM DUP('_')     
    occ DB CHARS DUP(0)     
     
.CODE
.STARTUP       


; 1- TAKING IN INPUT EVERY CHARACTER FOR EVERY LINE

    MOV CX, DIM ; reverse counter   
    XOR DI, DI   ; counter
    MOV AH, 1   ; reading setting
    INT 21H     ; read a char, put in AL

lab:    MOV line(DI), AL
        INC DI
        INT 21H
        
        CMP AL, 13  ; jump if ENTER (10 = LF)
        JNZ cond
        CMP DI, MIN
        JNC exit1
        
        cond1: DEC CX      ; jump condition if
               CMP CX, 0   ; the 50th char has
               JNZ lab    ; been inserted
exit1: 


; 2- COUNTING OCCURRENCES OF EVERY CHARACTER

	MOV DI, 0	; iterator init
	MOV AH, 0
dict:   MOV AL, line[DI]

	CMP AL, underline ; compare to '_'
	JZ enddict	  ; and jump if equal

	SUB AL, 65
	MOV SI, AX    ; update counter of caracter
	INC occ[SI]
	INC DI
	CMP DI, DIM
	JNZ dict
enddict:


; 3- LOOKING FOR MAX OCCURRENCE
	
	XOR DI, DI
	XOR AL, AL ; max
	XOR BL, BL ; temp var
	XOR CX, CX ; value to print

count:	MOV BH, line[DI]
	COMP AL, BL
	JAE notmax

	MOV AL, BL
	MOV CX, DI
	ADD CX, 65
	
notmax:
	INC DI
	CMP DI, CHARS
	JNZ count


; 4- PRINT MAX VALUE
	
	MOV DH, AL ; save max value

	MOV AH, 2
	MOV DL, CL
	INT 21h	   ; value repetead max times

	MOV AH, 2
	MOV DL, ' ' 
	INT 21h    ; space

	;PRINT DH ; number of occurrences
	
	MOV AH, 2
	MOV DL, 13
	INT 21h
	MOV AH, 2
	MOV DL, 10
	INT 21h   ; break line


; 5- PRINT >= MAX/2 VALUES

	LSR DH, 1  ; max/2 value rounded down
	;ADC DH, 0 ; if round up required
	XOR DI, DI
	
notprintedyet:
	MOV BL, occ1[DI]
	CMP BL, DH
	JB noprint
	ADD DI, 65
	; PRINT DI ; value repetead
	; PRINT " "
	; PRINT BL ; number of occurrences
	; PRINT '\n'

noprint:
	SUB DI, 64
	CMP DI, CHARS
	JNZ notprintedyet
    
.EXIT
END

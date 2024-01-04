# ARM Exercises

In this repository, there are some exercises computed during the Computer Architectures II class, solved using ARM assembly language or even 8086 assembly language.

---
## IEEE-754 Converter
In the first file [IEEE-754 Converter](/ieee754_converter/startup_LPC17xx.s), there is code capable of transforming an _unsigned_ 32-bit number into a floating-point one, according to the IEEE-754 standard. It uses a coprocessor call (CDP) that takes four parameters in input in the following order and according to the following signature:

```asm
    CDP  p0,  imm,  dest,  int,  frac,  sign
```
- `p0` is the co-processor used
- `imm` is the operation executed by the co processor; IEEE-754 converter uses `#1` 
- `int` is the integer part of the number to be converted (mapped ad `cn`)
- `frac` is the fractional part of the number to be converted (mapped ad `cn`)
- `sign` is the sign of the numner (`#0` for positive, `#1` for negative)
Finally, since LCP17xx does not have any co-processor, its registers are c0-c7, mapped to CPU registers r4-r11.

This is an example of the call to this coprocessor function used to convert the decimal number `1998.142578125`:

```asm
    LDR r5, =142578125 ; frac part -> c1
    MOV r6, #1998 ; integer -> c2
    ; destination address r7 -> c3
        
    CDP p0, #1, c3, c2, c1, #0
```
The result is `0x44F9C490`, so the binary value: `0100 0100 1111 1001 1100 0100 1001 0000`

---
## LED Management
In folder [Led Management](/led_management) there are simple codes written in C used to turn on and off led on board. The implementation is based on ARM structure, that stores memory-mapped registers that manage leds activity. In particular:

```cpp
    LPC_GPIO2 -> FIOSET // turn on
    LPC_GPIO2 -> FIOCLR // turn off
 ```
These lines are used to access memory-mapped registers. For our purpose, only last eight bits are modified, as shown in [function_library](/led_management/led/funct_led.c).

---
## String Reader & Occurences Management in 8086
In folder [String Reader 8086](/string_reader_8086) there is a code written in 8086 assembly code able to take in input a string of chars (a...z, A...Z) of length between 20 and 50, store it in a a variable, count the charcter occurring the `max` times and print it; then, the program will print all character occurring at least `max/2` times. To get the input, the interrupt 21h has been used, that is implemented in the following sintax:

```asm
    MOV AH, 1   ; reading setting
    INT 21H     ; read a char, put it in AL
```
- `AH` is used to set the interrupt type
- `AL` will contain the value provided in input
- `INT 21h` interrupt to be used

In order to manage char type, a dictionary (an array) of length 26 initialized to all zeros has been used. In this way, accessing a character occurrence is possible by taking its ascii value, decrement id by 65 and then access array with this displacement.

```asm
    SUB AL, 65
    XOR AH, AH
    MOV DI, AX
    INC dict[DI]
```

Instead, to print values in the standard output, another type of interrupt has been used, that is: 

```asm
	MOV AH, 2
	MOV DL, 'a' ; value printed
	INT 21h	    ; interrupt 
```
- `AH` is set to 2
- `DL` contains the value to be printed out
- `INT 21h` interrupt to be used

---
## Caesar Cipher in 8086
In folder [Caesar Encoder 8086](/ceasar_cipher_8086) there is a simple code written in 8086 assembly language able to encode using a line according to Caesar encrypting method, by using any key in range [0, 52]: this constraint is due to the meaningless usage of other keys. Just a note: in order to avoid printing unreadble chars (so in order to get only numbers in range [65, 122], and avoiding position in range [91, 96], too), further checks has been implemented.

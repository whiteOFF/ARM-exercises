# ARM-exercises

In this repository there are some exercises computed during class of Computer Architectures, solved using ARM assembly language.

## Classic -> IEEE-754 standard
In the first file [`IEEE-754 Converter`](/startup_LPC17xx.s) there is a code able to transform an unsigned number in 32 bits into a floating point one, according to the IEEE-754 standard. It uses a coprocessor call (CDP) that takes four parameters in input in the following order and according to the following signature:

    CDP  p0,  imm,  dest,  int,  frac,  sign

- `p0` is the co processor used
- `imm` is the operation executed by the co processor, IEEE-754 converter uses `#1` 
- `int` is the integer part of the number to be converted (mapped ad `cn`)
- `frac` is the fractional part of the number to be converted (mapped ad `cn`)
- `sign` is the sign of the numner (`#0` for positive, `1` for negative)

Finally, since LCP17xx has not any coprocessor, its registers are c0-c7, mapped to CPU register r4-r11.

This is an example of call of this coprocessor function:
  
        LDR r5, =142578125 ; frac part -> c1
        MOV r6, #1998 ; integer -> c2
        ; dest address r7 -> c3
        
        CDP p0, #1, c3, c2, c1, #0
the result is `0x44F9C490`, so the binary value: `0100 0100 1111 1001 1100 0100 1001 0000`

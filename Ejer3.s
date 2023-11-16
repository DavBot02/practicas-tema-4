.set    GPBASE,   0x3F200000
        .set    GPFSEL0,  0x00
		.set    GPFSEL1,  0x04
        .set    GPFSEL2,  0x08  
        .set    GPSET0,   0x1c
		.set	GPLEV0,	  0x34
		.set 	GPCLR0,   0x28
		/* guia bits     xx999888777666555444333222111000*/
		.set 	CONF1, 0b00000000001000000000000000000000
.text
        ldr     r0, =GPBASE
/* guia bits           xx999888777666555444333222111000*/
		ldr		r1, =CONF1
		str	r1, [r0, #GPFSEL1]
/* guia bits           10987654321098765432109876543210*/
loop:   mov   	r1, #0b00000000000000100000000000000000
        str     r1, [r0, #GPSET0]   @ Enciende GPIO 9
		mov   	r1, #0b00000000000000100000000010000000
        str     r1, [r0, #GPCLR0]   @ Enciende GPIO 9
		b		loop
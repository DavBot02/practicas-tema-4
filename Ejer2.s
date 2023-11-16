.set    GPBASE,   0x3F200000
        .set    GPFSEL0,  0x00
        .set    GPFSEL2,  0x08  
        .set    GPSET0,   0x1c
		.set	GPLEV0,	  0x34
		.set 	GPCLR0,   0x28
		/* guia bits     xx999888777666555444333222111000*/
        .set    CONF0, 0b00000000000000000000000000000000
		.set    CONF2, 0b00000000001000000000000001000000
.text
        ldr     r0, =GPBASE
/* guia bits           xx999888777666555444333222111000*/
        ldr   	r1, =CONF0
        str	r1, [r0, #GPFSEL0]  @ Configura GPIO 9
		ldr		r1, =CONF2
		str	r1, [r0, #GPFSEL2]
/* guia bits           10987654321098765432109876543210*/
        mov   	r1, #0b00001000010000000000000000000000
        str     r1, [r0, #GPSET0]   @ Enciende GPIO 9
loop: 	mov 	r3, #0b0100
		mov 	r4, #0b1000
		ldr		r2, [r0, #GPLEV0]
		tst		r2, r3
		beq		ontwo
		tst		r2, r4
		beq		onseven
		b		loop
	  /* guia bits     10987654321098765432109876543210*/
ontwo:	mov   	r1, #0b00001000000000000000000000000000
        str     r1, [r0, #GPCLR0]   @ Enciende GPIO 9
		b 		infi
onseven: mov	r1, #0b00000000010000000000000000000000
		str     r1, [r0, #GPCLR0]   @ Enciende GPIO 9
		b 		infi
infi:  	b       infi
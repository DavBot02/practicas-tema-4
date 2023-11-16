.set GPBASE, 	0x3F200000
	.set GPSEL0, 	0x00
	.set GPSEL1, 	0x04
	.set GPSET0, 	0x1c
	.set GPCLR0, 	0x28
	.set STBASE, 	0x3F003000
	.set STCLO, 	0x04
.text
	ldr r0, = GPBASE
/* guia bits   xx999888777666555444333222111000 */
	mov r1, #0b00000000000000000001000000000000
	str r1, [ r0, #GPSEL0 ] @ Configura GPIO 17
/* guia bits   10987654321098765432109876543210 */
	mov r1, #0b00000000000000000000000000010000
	ldr r2, = STBASE
	
bucle : bl espera @ Salta a rutina de espera
	str r1, [ r0, #GPSET0 ]
	bl espera @ Salta a rutina de espera
	str r1, [ r0, #GPCLR0 ]
	b bucle
	
/* rutina que espera medio segundo */
espera : ldr r3, [ r2, #STCLO ] @ Lee contador en r3
	ldr r4, = 956
	add r4, r3 @ r4= r3+ medio mill ón
ret1 : ldr r3, [ r2, #STCLO ]
	cmp r3, r4 @ Leemos CLO hasta alcanzar
	blo ret1
	bx lr
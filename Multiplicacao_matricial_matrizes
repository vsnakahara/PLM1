	.section .data
#A(mxn) e B(nxp)
abertura:	.asciz		"********* Multiplicacao matricial para matrizes ********\n"
input1:			.asciz		"\nDigite o numero de linhas da matriz A: "
input2:			.asciz		"\nDigite o numero de colunas da matriz A (e numero de linhas da matriz B): "
input3:			.asciz		"\nDigite o numero de linhas da matriz B: "
formato:	.asciz		"%d"

m:	.int 	0
n:	.int 	0
p:	.int 	0

.section .text

.globl _start

_start:
	pushl 	$abertura
	call	printf

	pushl 	$input1
	call 	printf
	pushl	$m
	pushl	$formato
	call	scanf

	pushl 	$input2
	call	printf
	pushl	$n
	pushl	$formato
	call 	scanf

	pushl	$input3
	call	printf
	pushl 	$p
	pushl	$formato
	call 	scanf

	pushl	p
	pushl	n
	pushl	m
	
	pushl	$0
	call	exit




.section .data
#A(mxn) e B(nxp)
abertura:	.asciz		"********* Multiplicacao matricial para matrizes ********\n"
input1:		.asciz		"\nDigite o numero de linhas da matriz A: "
input2:		.asciz		"\nDigite o numero de colunas da matriz A (e numero de linhas da matriz B): "
input3:		.asciz		"\nDigite o numero de linhas da matriz B: "
formato:	.asciz		"%d"
breakline:  .asciz 		"\n"
mostra1:    .asciz "Elementos Lidos: " 
pedenum:    .asciz "Digite o elemento da matriz A: "
pedenum2:   .asciz "Digite o elemento da matriz B: "
matrizA: 	.space 900
matrizB: 	.space 900

mostra2:   .asciz " %d \n"

totElementosA: .int 0
totElementosB: .int 0 
contLinha: 	   .int 0
m:			   .int 0
n:			   .int 0
p:			   .int 0
num: 		   .int 0

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

limpaReg:
	movl $0, %eax 
	movl $0, %ebx 
	movl $0, %ecx 
	movl $0, %edi

calcularElementos:
	pushl $limpaReg
	movl m, %eax
	movl n, %ebx 
	mull %ebx
	movl %eax, totElementosA
	pushl totElementosA
	pushl $formato
	call printf

calcularElementosB:
	pushl $limpaReg
	movl p, %eax
	movl n, %ebx 
	mull %ebx
	movl %eax, totElementosB
	pushl totElementosB
	pushl $formato
	call printf

criarMatrizA:
	movl totElementosA, %ecx
	movl $matrizA , %edi  #endereco inicial do vetor 
	addl $16, %esp      #descarta elementos empilhados   
	movl $0 , %ebx	

lenum:
	incl %ebx 
	pushl %edi #backupeia %edi , %ecx , %ebx 
	pushl %ecx 
	pushl %ebx 

	pushl $pedenum
	call printf 
	pushl $num
	pushl $formato 
	call scanf
	pushl $breakline
	call printf 
	addl $16 , %esp 

	popl %ebx
	popl %ecx
	popl %edi
	movl num, %eax
	movl %eax , (%edi) #coloca posição corrente do vetor
	addl $4, %edi      #avança 4 bits de posição no vetor ?! 
	loop lenum

criarMatrizB:
	pushl $limpaReg
	movl totElementosB, %ecx
	movl $matrizB , %edi  #endereco inicial do vetor 
	addl $16, %esp      #descarta elementos empilhados   
	movl $0 , %ebx		

lenum2:
	incl %ebx 
	pushl %edi #backupeia %edi , %ecx , %ebx 
	pushl %ecx 
	pushl %ebx 

	pushl $pedenum2
	call printf 
	pushl $num
	pushl $formato 
	call scanf
	pushl $breakline
	call printf 
	addl $16 , %esp 

	popl %ebx
	popl %ecx
	popl %edi
	movl num, %eax
	movl %eax , (%edi) #coloca posição corrente do vetor
	addl $4, %edi      #avança 4 bits de posição no vetor ?! 
	loop lenum2


mostravet:
	pushl $limpaReg
	pushl $mostra1 
	call printf 
	addl $4, %esp 
	movl totElementosB, %ecx 
	movl $matrizB, %edi 


# pulalin:
# 	pushl $breakline
# 	call printf

mostranum:
	addl $4, %edi ## PULA PARA O SEGUNDO ELEMENTO -- EXEMPLO
	movl (%edi) , %ebx 
	pushl %edi 
	pushl %ecx
	pushl %ebx
 
	pushl $mostra2
	call printf
	
	pushl	$0
	call	exit








################################# UTILS ###############################

# mostravet:
# 	pushl $limpaReg
# 	pushl $mostra1 
# 	call printf 
# 	addl $4, %esp 
# 	movl totElementosB, %ecx 
# 	movl $matrizB, %edi 


# # pulalin:
# # 	pushl $breakline
# # 	call printf

# mostranum:
# 	movl (%edi) , %ebx 
# 	addl $4, %edi      #avanca 4
# 	pushl %edi 
# 	pushl %ecx
# 	pushl %ebx

# 	pushl $mostra2
# 	call printf
# 	addl $8, %esp    #avanca  8 ? 

# 	popl %ecx
# 	popl %edi 
	
# 	movl $1 , %eax 
# 	addl contLinha, %eax 
# 	movl %eax,  contLinha
# 	movl contLinha,  %eax

# 	# cmpl $2, %ebx
# 	# je   pulalin

# 	loop mostranum
	
# 	## MOSTRA O TOTAL DE ELEMENTOS 
# 	pushl $breakline
# 	call printf

# 	pushl contLinha
# 	pushl $formato
# 	call printf

# 	pushl $breakline
# 	call printf
# 	## FIM TOT ELEMENTOS  
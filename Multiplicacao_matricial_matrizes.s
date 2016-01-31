.section .data
 
abertura:	   .asciz "\n{  		  Multiplicacao matricial para matrizes                   }\n"
integrantes:   .asciz "{_________ Rafael Altar _ RA: 83021 - Vanessa Nakahara _ RA: 83550 _______}\n"
input1:		   .asciz "\nDigite o numero de linhas da matriz A: "
input2:		   .asciz "\nDigite o numero de colunas da matriz A (e numero de linhas da matriz B): "
input3:		   .asciz "\nDigite o numero de linhas da matriz B: "
pedenum:       .asciz "Digite o elemento da matriz A: "
pedenum2:      .asciz "Digite o elemento da matriz B: "
matrizA: 	   .space 900
matrizB: 	   .space 900
matrizC: 	   .space 1800

showElemento:  .asciz " %d \n"
formato:	   .asciz "%d"
breakline:     .asciz "\n"

num: 		   .int 0
constCol:	   .int 0 
soma: 		   .int 0

## Totais de elementos da matriz
totElementosA: .int 0
totElementosB: .int 0 
totElementosC: .int 0 

## Posição dos elementos na matriz
indiceA:       .int 0
indiceB:       .int 0
indiceC:       .int 0

## Elementos da matriz
elementoA:     .int 0 
elementoB:	   .int 0 

## Linhas e Colunas das Matrizes 
m:			   .int 0
n:			   .int 0
p:			   .int 0

## Indices auxiliares para o loop
j:			   .int 0
k:			   .int 0
i:			   .int 0

.section .text

.globl _start

_start:

	pushl 	$abertura
	call	printf

	pushl 	$integrantes
	call	printf

	pushl 	$input1
	call 	printf
	pushl	$m            #LINHA A 
	pushl	$formato
	call	scanf

	pushl 	$input2
	call	printf
	pushl	$n  		 #COLUNA A , LINHA B
	pushl	$formato
	call 	scanf

	pushl	$input3
	call	printf
	pushl 	$p          #COLUNA B
	pushl	$formato
	call 	scanf

	pushl $breakline
	call printf

 calcularElementos:
 	call limpaReg
 	movl m, %eax
 	movl n, %ebx 
 	mull %ebx
 	movl %eax, totElementosA
 	pushl totElementosA

 calcularElementosB:
 	call limpaReg
 	movl p, %eax
 	movl n, %ebx 
 	mull %ebx
 	movl %eax, totElementosB

calcularElementosC:
 	call limpaReg
 	movl p, %eax
 	movl m, %ebx 
 	mull %ebx
 	movl %eax, totElementosC

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
	call limpaReg
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

getConstante:
	call limpaReg
	movl p, %eax
	movl $4, %ebx 
	mull %ebx
	movl %eax, constCol
	
main:
	movl m, %ecx 
	movl $matrizA, %edi
	movl $matrizB, %esi 
	movl $matrizC, %ebp

# $m ->LINHA A  ; n ->COLUNA A & LINHA B ;  $p ->COLUNA B
#A(mxn) e B(nxp)

loopLinhaA: #<< Inicia LoopA para Linhas
	pushl %ecx
	movl p , %ecx
	movl $0 , j
		
		colunaB: #<< Inicia LoopB para Colunas
			pushl %ecx
			movl n , %ecx
			movl $0 , k
			movl $0 , soma
			
				linhaB:	#<< Inicia LoopB para Linhas
					pushl %ecx	

					call getElementoA

					call getElementoB
			
					call setMatrizC

					incl k
					popl %ecx

					movl $0, elementoA
					movl $0, elementoB
					
				loop linhaB #<< Finaliza LoopB para Linhas

			incl j	
			popl %ecx
			

		loop colunaB #<< Inicia LoopB para Colunas
	popl %ecx
	incl i

loop loopLinhaA # Finaliza LoopA para Linha >>

mostraMatrizC:
	movl totElementosC, %ecx
	pushl %ecx
	jmp getMatrizResultante


## INICIO DAS ROTINAS ##
limpaReg:
	movl $0, %eax 
	movl $0, %ebx 
	movl $0, %ecx 
	movl $0, %edi
ret

getIndiceA:
	movl i , %eax
	movl n, %ebx
	mull %ebx
	movl k,  %edx
	addl %eax , %edx

	movl %edx, %eax
	movl $4, %ebx
	mull %ebx
	movl  %eax,indiceA
ret

getIndiceB:
	movl k , %eax
	movl p, %ebx
	mull %ebx
	movl j,  %edx
	addl %eax , %edx

	movl %edx, %eax
	movl $4, %ebx
	mull %ebx
	movl %eax,indiceB
ret

getIndiceC:
	movl i, %eax
	movl p, %ebx
	mull %ebx
	movl j,  %edx
	addl %eax , %edx

	movl %edx, %eax
	movl $4, %ebx
	mull %ebx
	movl %eax,indiceC
ret

getElementoA:
	call getIndiceA			
	movl indiceA, %eax
	pushl %edi
	addl %eax, %edi
	movl (%edi), %ebx
	movl %ebx, elementoA
	popl %edi				
ret


getElementoB:
	call getIndiceB
	movl indiceB, %eax
	pushl %esi
	addl %eax, %esi
	movl (%esi) , %ebx
	movl %ebx, elementoB
	popl %esi			
ret

setMatrizC:
	pushl %ebp
	call getIndiceC
	addl indiceC, %ebp

	movl elementoA, %eax
	movl elementoB, %ebx
	mull %ebx
	
	addl %eax , soma
	movl soma , %ebx

    movl  %ebx , (%ebp)
	popl %ebp  
ret

getMatrizA:

ret

getMatrizB:

ret

getMatrizResultante:
	pushl %ecx
	
	movl (%ebp),%ebx
	addl $4, %ebp
	pushl %ebp
	pushl %ebx
	
	pushl $showElemento
	call printf
	addl $8, %esp

	popl %ebp
	popl %ecx
loop getMatrizResultante

## FIM DAS ROTINAS ##

fim:
	pushl	$0
	call	exit

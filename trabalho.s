.section .data
 
abertura:	   .asciz "\n{  		  Multiplicacao matricial para matrizes                   }\n"
integrantes:   .asciz "{_________ Rafael Altar _ RA: 83021 - Vanessa Nakahara _ RA: 83550 _______}\n"
input1:		   .asciz "\nDigite o numero de linhas da matriz A:\n> "
input2:		   .asciz "\nDigite o numero de colunas da matriz A (e numero de colunas da matriz B):\n> "
input3:		   .asciz "\nDigite o numero de linhas da matriz B:\n> "
cabMatrizA:    .asciz "Matriz [ A ] Preenchida : \n"
cabMatrizB:    .asciz "\n\nMatriz [ B ] Preenchida : \n"
cabMatrizC:    .asciz "\n\nMatriz [ C ] Resultante : \n"
cabOpcaoSaida: .asciz "== Como deseja visualizar a matriz resultante? == \n"
opcoes:        .asciz "[ 1 ] Arquivo\n[ 2 ] Video \n> "
escritoArq:	   .asciz "Transcrita no arquivo %s \n\n"
finalizado:	   .asciz "\n\n== Programa Finalizado ==\n\n"

matrizA: 	   .space 900
matrizB: 	   .space 900
matrizC: 	   .space 1800

showElemento:  .asciz " %d\t"
breakline:     .asciz "\n"
formato:	   .asciz "%d"

showElementoFloat: .asciz " %lf\t"
showElementoBarra: .asciz " %lf\n"

showFloatLinha: .asciz " %.2lf\n"
showFloatTab:   .asciz " %.2lf\t"

showFloatQuebra: .asciz " %.2lf\n\n"

constCol:	   .int   0 
soma: 		   .float 0
num: 		   .int   0

## Totais de elementos da matriz
totElementosA: .int 0
totElementosB: .int 0 
totElementosC: .int 0 

## Posição dos elementos na matriz
indiceA:       .int 0
indiceB:       .int 0
indiceC:       .int 0

## Elementos da matriz
elementoA:     .float 0 
elementoB:	   .float 0 

## Linhas e Colunas das Matrizes 
m:			   .int 0
n:			   .int 0
p:			   .int 0
opt:		   .int 0

## Indices auxiliares para o loop
j:			   .int 0
k:			   .int 0
i:			   .int 0

ponteiroArqSaida: .int 0

formato1:         .asciz "%lf"
formato2:         .asciz "%.2lf"
str_arq_out:      .ascii "%.2lf"
tam_str_arq_out:  

formatoString:	   .asciz "%s"
formatoByte:	   .asciz ""
espaco: 		   .byte ' '
quebra: 		   .byte '\n'
enter: 			   .byte 10
return: 		   .byte 13
NULL: 			   .byte 0

auxValor:          .space 10000
arqMatrizA:	       .space 50
arqMatrizB:	   	   .space 50
arqMatrizC:	   	   .space 50
concat:			   .space 20
tamStrArqIn:	   .space 20000


pedeArqA:      .ascii "\nEntre com o nome do arquivo da Matriz A\n> "
fimPedeArqA: 

pedeArqB:      .ascii "\nEntre com o nome do arquivo da Matriz B\n> "
fimPedeArqB: 

pedeArqC:      .ascii "\nEntre com o nome do arquivo da Matriz C ( saida )\n> "
fimPedeArqC: 

.equ tamPedeArqA, fimPedeArqA-pedeArqA
.equ tamPedeArqB, fimPedeArqB-pedeArqB
.equ tamPedeArqC, fimPedeArqC-pedeArqC

SYS_EXIT: .int 1
SYS_FORK: .int 2
SYS_READ: .int 3
SYS_WRITE: .int 4
SYS_OPEN: .int 5
SYS_CLOSE: .int 6
SYS_CREATE: .int 8
	
STD_OUT: .int 1 #descritor do video
STD_IN:	 .int 2 #descritor do teclado

O_RDONLY:						.int 0x0000
O_WRONLY:						.int 0x0001
O_RDWR:							.int 0x0002
O_CREATE:						.int 0x0040
O_EXCL:							.int 0x0080
O_APPEND:						.int 0x0400
O_TRUNC:						.int 0x0200

S_IRWXU:						.int 0x01C0
S_IRUSR:						.int 0x0100
S_IWUSR:						.int 0x0080
S_IXUSR:						.int 0x0040
S_IRWXG:						.int 0x0038
S_IRGRP:						.int 0x0020
S_IWGRP:						.int 0x0010
S_IXGRP:						.int 0x0008
S_IRWXO:						.int 0x0007
S_IROTH:						.int 0x0004
S_IWOTH:						.int 0x0002
S_IXOTH:						.int 0x0001
S_NADA:							.int 0x0000

.section .bss

.section .text

.globl _start

_start:

	pushl 	$abertura
	call	printf
	addl 	$4, %esp

	pushl 	$integrantes
	call	printf
	addl 	$4, %esp

leNomeArquivos:
	movl SYS_WRITE, %eax
	movl STD_OUT, %ebx
	movl $pedeArqA, %ecx
	movl $tamPedeArqA, %edx
	int $0x80
	
	movl SYS_READ, %eax
	movl STD_IN, %ebx
	movl $arqMatrizA, %ecx
	movl $50, %edx
	int $0x80

	movl $arqMatrizA, %edi
	call tratanomearq
	

	movl SYS_WRITE, %eax
	movl STD_OUT, %ebx
	movl $pedeArqB, %ecx
	movl $tamPedeArqB, %edx
	int $0x80

	movl SYS_READ, %eax
	movl STD_IN, %ebx
	movl $arqMatrizB, %ecx
	movl $50, %edx
	int $0x80

	movl $arqMatrizB, %edi
	call tratanomearq

	movl SYS_WRITE, %eax
	movl STD_OUT, %ebx
	movl $pedeArqC, %ecx
	movl $tamPedeArqC, %edx
	int $0x80

	movl SYS_READ, %eax
	movl STD_IN, %ebx
	movl $arqMatrizC, %ecx
	movl $50, %edx
	int $0x80

	movl $arqMatrizC, %edi
	call tratanomearq


	jmp getDadosIniciais

tratanomearq:

	pushl %edi
	movl $-1, %ebx

volta3:

	addl $1, %ebx
	movb (%edi), %al
	cmpb enter, %al
	jz concluinomearq
	cmpb espaco, %al
	jz concluinomearq
	addl $1, %edi
	jmp volta3

concluinomearq:
	pushl %edi
	popl %edi
	movb NULL, %al
	movb %al, (%edi)
	addl $4, %esp
ret

getDadosIniciais:

	# Lê o nome do arquivo da matriz A
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

 #Calcula o total de elementos da matriz A 
 calcularElementos:
 	call limpaReg
 	movl m, %eax
 	movl n, %ebx 
 	mull %ebx
 	movl %eax, totElementosA
 	pushl totElementosA
 
 #Calcula o total de elementos da matriz B
 calcularElementosB:
 	call limpaReg
 	movl p, %eax
 	movl n, %ebx 
 	mull %ebx
 	movl %eax, totElementosB

#Calcula o total de elementos da matriz C
calcularElementosC:
 	call limpaReg
 	movl p, %eax
 	movl m, %ebx 
 	mull %ebx
 	movl %eax, totElementosC

#Percorre %edi , pulando 4 bytes para cada elemento

inicioLeitura:
	movl SYS_OPEN, %eax
	movl $arqMatrizA , %ebx
	movl O_RDONLY , %ecx
	int $0x80

#Incializa matriz A
criarMatrizA:
	movl totElementosA, %ecx
	movl $matrizA , %edi      #endereco inicial do vetor 
		
lenum:
	pushl %ecx 
	movl $auxValor, %esi

processaChar:
	push %eax			
	push %esi

		movl %eax, %ebx
		movl SYS_READ , %eax       ##1
		movl  $concat , %ecx
		movl  $1 , %edx
		int $0x80
		pop %esi
			
		movb concat, %al
		# cmpb espaco, %al
		# je  foi

		movb %al, (%esi)
		incl %esi
		pop %eax
		cmpb $0x0A, concat
		je converteString

		cmpb $0x20, concat
		jne processaChar


		converteString:
			push %eax                 #4
			movb $0x00,(%esi)
		  	push $auxValor            #5
		  	call atof
		  	addl $4, %esp

		  	fstpl (%edi)
		  	addl $8, %edi

			pop %eax	
			pop %ecx

loop lenum

movl SYS_CLOSE, %eax
int $0x80


# main1:
# 	movl $matrizA, %edi
# 	movl totElementosA, %ecx

# getMatrizA1:
# 	pushl %ecx

# 	fldl (%edi)
# 	subl $8, %esp
# 	fstpl (%esp)
# 	pushl $formato2
# 	call  printf
# 	addl $12, %esp
# 	addl $8, %edi
# 	popl %ecx	

# loop getMatrizA1


#Percorre %edi , pulando 4 bytes para cada elemento

inicioLeitura2:
	movl SYS_OPEN, %eax
	movl $arqMatrizB , %ebx
	movl O_RDONLY , %ecx
	int $0x80

#Incializa matriz A
criarMatriz2:
	movl totElementosB, %ecx
	movl $matrizB , %esi      #endereco inicial do vetor 
		
lenum3:
	pushl %ecx 
	movl $auxValor, %ebp

processaChar2:
	push %eax			
	push %ebp

		movl %eax, %ebx
		movl SYS_READ , %eax       ##1
		movl  $concat , %ecx
		movl  $1 , %edx
		int $0x80
		pop %ebp
			
		movb concat, %al
		# cmpb espaco, %al
		# je  foi

		movb %al, (%ebp)
		incl %ebp
		pop %eax
		cmpb $0x0A, concat
		je converteString2

		cmpb $0x20, concat
		jne processaChar2


		converteString2:
			push %eax                 #4
			movb $0x00,(%ebp)
		  	push $auxValor            #5
		  	call atof
		  	addl $4, %esp

		  	fstpl (%esi)
		  	addl $8, %esi

			pop %eax	
			pop %ecx


loop lenum3

movl SYS_CLOSE, %eax
int $0x80


# main2:
# 	movl $matrizB, %esi
# 	movl totElementosB, %ecx

# # getMatriz2:
# # 	pushl %ecx

# # 	fldl (%esi)
# # 	subl $8, %esp
# # 	fstpl (%esp)
# # 	pushl $formato2
# # 	call  printf
# # 	addl $12, %esp
# # 	addl $8, %esi
# # 	popl %ecx	

# # loop getMatriz2

#Move a linha da matriz A para iniciar os calculos dentro do loop	
main:
	movl m, %ecx 
	movl $matrizA, %edi
	movl $matrizB, %esi 
	movl $matrizC, %ebp


# # $m ->LINHA A  ; n ->COLUNA A & LINHA B ;  $p ->COLUNA B
# #A(mxn) e B(nxp)

loopLinhaA: #<< Inicia LoopA para Linhas
	pushl %ecx
	movl p , %ecx
	movl $0 , j
		
		colunaB: #<< Inicia LoopB para Colunas
			pushl %ecx
			movl n , %ecx
			movl $0 , k

			fldz
			fstpl soma		

			batata:
				linhaB:	#<< Inicia LoopB para Linhas
					pushl %ecx	

					call getElementoA

					call getElementoB
			
					call setMatrizC

					incl k
					popl %ecx
					
				loop linhaB #<< Finaliza LoopB para Linhas

			incl j	
			popl %ecx
			

		loop colunaB #<< Inicia LoopB para Colunas
	popl %ecx
	incl i

loop loopLinhaA # Finaliza LoopA para Linha >>
#Mostra a Matriz preenchida B

pedirOpcaoPrint:
	pushl $cabOpcaoSaida
	call printf
	pushl $opcoes
	call printf

	pushl $opt  		
	pushl $formato
	call  scanf

	cmpl $1 , opt
	je mostraMatC

	cmpl $2 , opt
	jne incializaPrintCVideo


incializaPrintCVideo:
	pushl $cabMatrizC
	call printf
	addl $4, %esp

	movl $matrizC , %ebp
	movl totElementosC , %ecx
	# Inicializar o contador do pula liha
	movl $1, %eax
	movl %eax, j
elementoMatrizC:
	# Reatira da matriz e coloca na pilha para a chamada do printf
	fldl (%ebp)
	movl %ecx, i
	subl $8, %esp
	fstpl (%esp)
	# Verifica se ja foi escrito todo uma linha para ocorrer o '\n'
	movl j, %eax
	cmp p,%eax
	jne motraComTab
	# Formato quebra linha
	movl $1,%eax
	movl %eax, j
	pushl $showFloatLinha
	jmp mostraComQuebra
motraComTab:
	# Formato continua linha
	incl %eax
	movl %eax, j
	pushl $showFloatTab
mostraComQuebra:
	call printf
	addl $12,%esp
	addl $8,%ebp
	movl i,%ecx
	loop elementoMatrizC
jmp fim

mostraMatC:
	movl SYS_OPEN, %eax # system call OPEN: retorna o descritor em %eax
	movl $arqMatrizC, %ebx
	movl O_WRONLY, %ecx
	orl  O_CREATE, %ecx
	movl S_IRUSR, %edx
	orl  S_IWUSR, %edx
	int  $0x80
	movl %eax, ponteiroArqSaida
	movl totElementosC , %ecx

getMatrizC:
	pushl %ecx

	fldl (%ebp)
	subl $8, %esp
	fstpl (%esp)
	pushl $showFloatLinha
	pushl $str_arq_out
	call  sprintf
	addl  $16, %esp

	# movl %ecx, %eax
	# movl $0,%edx
	# movl p,%ebx
	# divl %ebx
	# cmpl $0, %ebp
	movl  ponteiroArqSaida, %ebx
	movl  SYS_WRITE, %eax
	movl  $str_arq_out, %ecx
	movl  %eax, %edx
	int   $0x80
	
	addl $8, %ebp
	popl %ecx


loop getMatrizC

pushl $cabMatrizC
call printf
addl $4, %esp

pushl $arqMatrizC
pushl $escritoArq
call printf
add $4, %esp

jmp fim
#Mostra a Matriz preenchida A


Escreve:
	popl %ebp
	popl %edx
	popl %ecx
	popl %ebx
	popl %eax
	movl  ponteiroArqSaida, %ebx
	movl  SYS_WRITE, %eax
	movl  $str_arq_out, %ecx
	movl  %eax, %edx
	int   $0x80

	popl  %ecx
	popl  %ebx	
	popl %edx
ret


mostraMatA:
	pushl $cabMatrizA
	call printf
	addl $4, %esp
	movl totElementosA , %ecx


getMatrizA:
	pushl %ecx

	fldl (%edi)
	subl $8, %esp
	fstpl (%esp)
	
	movl %ecx, %eax
	movl $0,%edx
	movl m,%ebx
	divl %ebx
	cmpl $0, %edx

	jne tipoUmBreak 
	pushl $showElementoFloat
	jmp tipoOutro 

tipoUmBreak:
	pushl $showElementoBarra
	
	tipoOutro:
		call  printf

		addl $18, %esp

		addl $8, %edi
		popl %ecx	

loop getMatrizA

#Mostra a Matriz preenchida B
mostraMatB:
	pushl $cabMatrizB
	call printf
	addl $4, %esp
	movl totElementosB , %ecx

getMatrizB:
	pushl %ecx

	fldl (%esi)
	subl $8, %esp
	fstpl (%esp)
	
	movl %ecx, %eax
	movl $0,%edx
	movl n,%ebx
	divl %ebx
	cmpl $0, %edx
	jne controlaLoopB 
	pushl $showElementoFloat
	jmp controlaPrintB

controlaLoopB:
	pushl $showElementoBarra
	
	controlaPrintB:
		call  printf
		addl $12, %esp
		addl $8, %esi
		popl %ecx	
loop getMatrizB


mostraMatrizC:
	pushl $cabMatrizC
	call printf
	call limpaReg
	movl totElementosC, %ecx
	pushl %ecx
	jmp setMatrizC


## INICIO DAS ROTINAS ##
#Rotina para limpar os registradores
limpaReg:
	movl $0, %eax 
	movl $0, %ebx 
	movl $0, %ecx 
ret

#Rotina para pegar a posição do elemento da matriz A
getIndiceA:
	movl i , %eax
	movl n, %ebx
	mull %ebx
	movl k,  %edx
	addl %eax , %edx

	movl %edx, %eax
	movl $8, %ebx
	mull %ebx
	movl  %eax,indiceA
ret

#Rotina para pegar a posição do elemento da matriz B
getIndiceB:
	movl k , %eax
	movl p, %ebx
	mull %ebx
	movl j,  %edx
	addl %eax , %edx

	movl %edx, %eax
	movl $8, %ebx
	mull %ebx
	movl %eax,indiceB
ret

#Rotina para pegar a posição que sera inserido o elemento na matriz C
getIndiceC:
	movl i, %eax
	movl p, %ebx
	mull %ebx
	movl j,  %edx
	addl %eax , %edx

	movl %edx, %eax
	movl $8, %ebx
	mull %ebx
	movl %eax,indiceC
ret

#Rotina para pegar o elemento contido na posição já buscada da matriz A
getElementoA:
	call getIndiceA			
	movl indiceA, %eax
	pushl %edi
	
	addl %eax, %edi
	fldl (%edi) 
	
	popl %edi				

ret

#Rotina para pegar o elemento contido na posição já buscada da matriz B
getElementoB:
	call getIndiceB			
	movl indiceB, %eax
	pushl %esi

	addl %eax, %esi
	fldl (%esi) 
	
	popl %esi		
ret

#Preenche a matriz C utilizando os elementos buscados em A e B 
setMatrizC:
	 pushl %ebp
	 call getIndiceC
	 addl indiceC, %ebp
	 # subl $8, %esp
	 fmul %st(1), %st(0)
	 fldl soma
	 fadd %st(1), %st(0)
	 fstpl soma 

	 fldl soma
	 fstpl (%ebp)

	 # Limpesa dos registradores

	 subl $8, %esp
	 fstpl (%esp)
	 addl $8, %esp

	 subl $8, %esp
	 fstpl (%esp)
	 addl $8, %esp

	 popl %ebp 

	#  fstpl (%esp)
	#  pushl $formato1
	#  call printf
	#  call exit
	# # fldl elementoA
	# subl $8, %esp
	# fstpl (%esp)
	# pushl $formato1
	# call printf
	# addl $12, %esp


	#subl $8, %esp
	#fstpl (%esp)
	# pushl $formato1
	# call printf
	# addl $12, %esp
	
	# call exit

	# movl elementoA, %eax
	# movl elementoB, %ebx
	# mull %ebx
	
	# addl %eax , soma
	# movl soma , %ebx

 #    movl  %ebx , (%ebp)
	# popl %ebp  
	
ret

#Mostra a Matriz preenchida resultante
# getMatrizResultante:
# 	pushl %ecx
	
# 	movl (%ebp),%ebx
# 	addl $4, %ebp
# 	pushl %ebp
# 	pushl %ebx
	
# 	pushl $showElemento
# 	call printf
# 	addl $8, %esp

# 	popl %ebp
# 	popl %ecx


# 	movl %ecx, %eax
# 	movl $0,%edx
# 	movl p,%ebx
# 	divl %ebx
# 	cmpl $1, %edx
# 	jne contMR
# 	movl %ecx,%ebx
# 	pushl $breakline
# 	call printf
# 	movl %ebx,%ecx
# contMR:
# 	loop getMatrizResultante

pulaLinha:
	pushl $breakline
	call printf

## FIM DAS ROTINAS ##

fim:
	pushl $finalizado
	call printf
	addl $4, %esp

	pushl	$0
	call	exit


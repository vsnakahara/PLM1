.section .data 

	titulo:    .asciz "\n...Teste da diretiva SPACE...."
	formato:   .asciz "%d"
	pedetam:   .asciz "Digite o tamanho do vetor (max = 20) : "
	pedenum:   .asciz "Digite o elemento %d : "
	mostra1:   .asciz "Elementos Lidos: " 
	mostra2:   .asciz " %d"
	mostra3:   .asciz "Elementos Invertidos: "
	breakline: .asciz "\n"
	maxtam:    .int   20
	tam:       .int   0
	num:       .int   0
	soma:      .int   0
	vetor: 	   .space 80 # 4 bits para cada num armazenado
	contLinha: .int   0

	.section .text
	
.globl _start
_start:

cabecalho:
	pushl $titulo 
	call printf 	

letam: 
	pushl $pedetam 
	call printf 
	pushl $tam 
	pushl $formato
	call scanf
	pushl $breakline
	call printf

	movl tam, %ecx
	cmpl $0, %ecx
	jle  letam   #se for menor ou igual a zero faz letam de novo 

	cmpl maxtam, %ecx 
	jg letam      #se for maior que o tamanho total do vetor, letam tambem

	movl $vetor , %edi  #endereco inicial do vetor 
	addl $16, %esp      #descarta elementos empilhados   
	movl $0 , %ebx		#usa para enumerar os elementos lidos 

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

mostravet:
	pushl $mostra1 
	call printf 
	addl $4, %esp 
	movl tam, %ecx 
	movl $vetor, %edi 


# pulalin:
# 	pushl $breakline
# 	call printf

mostranum:
	movl (%edi) , %ebx 
	addl $4, %edi      #avanca 4
	pushl %edi 
	pushl %ecx
	pushl %ebx

	pushl $mostra2
	call printf
	addl $8, %esp    #avanca  8 ? 

	popl %ecx
	popl %edi 
	
	movl $1 , %eax 
	addl contLinha, %eax 
	movl %eax,  contLinha
	movl contLinha,  %eax

	# cmpl $2, %ebx
	# je   pulalin

	loop mostranum
	
	## MOSTRA O TOTAL DE ELEMENTOS 
	pushl $breakline
	call printf

	pushl contLinha
	pushl $formato
	call printf

	pushl $breakline
	call printf
	## FIM TOT ELEMENTOS  

fim:
	pushl $0
	call exit 

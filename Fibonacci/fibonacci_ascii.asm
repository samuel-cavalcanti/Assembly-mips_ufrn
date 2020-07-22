# Samuel Cavalcanti Matricula 20160108682

.data
	
	
	typeANumber: .asciiz "Digite um Valor inteiro N: "
	
	errorMessage: .asciiz "\n voce digitou um valor menor ou igual a zero !!\n"
	
	jumpLine : .asciiz "\n"

.text
	main: # procedure principal ou "funcao" princial 
		
		
		la $a0, typeANumber # carregando a label typeANumber no registrador a0 , a0 he dos registradores lidos para executar uma syscall 
		jal displayMessage
		
		jal loadUserInput
		
		
		move $a0, $v0 # argumento da funcao o verifyInput he o valor inserido pelo usuario 
		jal verifyInput
		
		move $a0, $v0 # argumento da funcao fibonacci he o valor inserido pelo usuario
		jal fibonacci
	
							
		jal exitProgram
	
	
	
	displayMessage:
		li $v0, 4 # carregando o servico print string no registrador v0 
		syscall # chamando a syscall
		
		jr $ra # voltar para onde veio 
		
		
	loadUserInput:
		li $v0, 5 #carregando o servico read 
		syscall	  # chamando a syscall read integer
		
		jr $ra # voltar para onde veio 
	
	
	
	verifyInput:
		add $t0, $zero , 1 # t0 = 1
			
		
		bgt $t0,$a0, greaterOrEgualThem1 # se $a0 for maior ou igual 1 entao -> 
			
			jr $ra # voltar para onde veio 
		 
		
		#caso contrario 
		greaterOrEgualThem1:
		
		la $a0, errorMessage # carregando a label errorMessage no registrador a0 , a0 he dos registradores lidos para executar uma syscall 
		
		jal displayMessage
		
		jal exitProgram
		
		
	
	
	fibonacci:
		
		move $t7, $ra # nao perder a referencencia da funcao anterior
		
		move $t1, $zero # registrador t1  = 0
		sub $t2 , $a0 , 1  # registrador  t2 = N -1
		
		move $t3, $zero # t3 = fib0
		
		add $t4, $zero, 1 # t4 = fib1
		
		
		begin_for:
		bgt $t1, $t2, exit_for
	 		
	 		move $a0, $t3 # printInteger rescebe como argumento o resgistrador t1
	 		jal printInteger
	 		
	 		move $t5, $t3
	 		
	 		move $t3 , $t4
	 		
	 		
	 		add $t4, $t4 , $t5
	 		
	 		
	 		
	 		addi $t1, $t1, 1 # encremeta o resgistrador t1
	 	
	 	
		j begin_for
		
		exit_for:
		jr $t7 # voltar para onde veio 
	
	
	printInteger: # imprime o valor presente no registador $a0
	
		move $t0 $a0
		
		
		li $v0, 4 # carregando o servico print string no registrador v0 
		la $a0, jumpLine # carregando a label jumpLine no registrador a0 , a0 he dos registradores lidos para executar uma syscall 
		syscall # chamando a syscall
		
		move $a0, $t0

		li $v0, 1 # carregando o servico print int no registrador v0 
		syscall # chamando a syscall
		jr $ra # voltar para onde veio 
	
	exitProgram:
		li $v0,10
		syscall

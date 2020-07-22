# Samuel Cavalcanti Matricula 20160108682

.data
	
	MenuMessage: .asciiz "\n Escolha uma opcao:\n\t1 - Adicao\n\t2 - Subtracao\n\t3 - Multiplicacao\n\t4 - Divisao\n\t5 - AND logico\n\t6 - OR logico\n\t7 - Sair\nOpcao: "
	
	insertValueMessage: .asciiz "\n Digite um numero: "
	
	ResultMessage:.asciiz "Resultado he\t"
	
	quotientMessage: .asciiz "Quociente: "
	
	remainderMessage: .asciiz  "\tRresto: "
	
	#		0	4	8	 12       16		20	     24
	options: .word sum, subtract, multiply, divide, AndOperator, OrOperator, exitProgram 
	# cada endereço tem 4 bytes 
	
.text 
	main:	
		
		
		jal getUserInputWithMessage
		
		move $s0, $v0 # carregando o valor digitado no inteiro no registrador s0
		
		jal getUserInputWithMessage
		
		move $s1, $v0 # carregando o valor digitado no inteiro no registrador s1
		
		
		jal menu
		
		
	
	menu:
	
		jal displayMenuMesssage
		
		jal loadUserInput
		
		sub $t0, $v0, 1 # carregando o valor digitado -1  no registrador s2
		
		
		mul $t0, $t0, 4 # tem que pular em 4 bytes para pegar o endereço 
		
		
		lw $t1, options($t0)  # carregando uma palavra (lw load word) do meu arry de palavras, no qual cada palavra reprenta uma label  
		
		
		jr $t1 # ir para label
		
		
	
	
	
	sum:
		
		la $a0, quotientMessage 
		jal displayMessage
		
		
		add $a0, $s0, $s1
	 	
		jal printResut
	
	subtract:
	
		 sub $a0, $s0, $s1
	 	
		 jal printResut
	
	 
	 
	 multiply:
	 	 mul $a0, $s0, $s1
	 
		 jal printResut
	
	 
	 
	 divide:
	 	 div $s0, $s1
	 	 
	 
	 	 # existem registradores especiais que quardam o quociente e o resto, para acessa-los use mflo e mfhi
	 	 la $a0, quotientMessage # messagem quociente (quotientMessage)
	 	 mflo $a1 # pega o valor do quociente e coloca no a1  
	 	 jal displayDivite
	 	 
	 	 la $a0 ,remainderMessage # messagem resto (remainderMessage)
	 	 mfhi $a1  # pega o resto da divisao e coloca no a1  
	 	 jal displayDivite
	 	 
	 	 
	 	  	  	 
		 jal menu
	
	 
	 AndOperator:
	 	 and  $a0, $s0, $s1
	 	
	 
		 jal printResut
	
	 
	 OrOperator:
	 
		 or $a0, $s0, $s1
	 
	 
		 jal printResut
	
	
	exitProgram:
		li $v0,10 
		syscall
		
		
	
	printResut: # imprime o valor presente no registador $a0
	
		move $t0 $a0
		
		la $a0, ResultMessage # carregando a label jumpLine no registrador a0 , a0 é dos registradores lidos para executar uma syscall 	
		jal displayMessage
	
		
		move $a0, $t0
		jal printInteger
		
		
		jal menu # vai para o menu
	
	printInteger:
		li $v0, 1 # carregando o serviço print int no registrador v0 
		syscall # chamando a syscall
		
		jr $ra # volta da onde veio
		
		
	
		
		
		
	
	displayMenuMesssage:
		la $a0, MenuMessage
		move $t0, $ra
		jal displayMessage

		jr $t0
	
	
	displayMessage:
		li $v0, 4 # carregando o servico print string no registrador v0 
		syscall # chamando a syscall
		
		jr $ra # voltar para onde veio 
		
		
	loadUserInput:
	
		li $v0, 5 #carregando o servico read 
		syscall	  # chamando a syscall read integer
		
		jr $ra # voltar para onde veio 
	
	
	displayDivite:
		
		 move $t0, $ra # lembrar o caminho de volta
		 
		 move $t2, $a0 # messangem de quociente ou resto 
		 move $t3, $a1 # valor do quociente ou resto
		
											
		 move $a0, $t2
	 	 jal displayMessage
	 	 
	 	 
	 	 move $a0, $t3
	 	 
	 	 jal printInteger
	 	 
	 	 jr $t0 # voltar para a função anterior
	 
	 
	 getUserInputWithMessage:
	 	move $t0, $ra # lembrar o caminho de volta
	 	
	 	la $a0, insertValueMessage
		jal displayMessage
		
		jal loadUserInput # retorna um valor no registrador $v0
	 	
	 	jr $t0
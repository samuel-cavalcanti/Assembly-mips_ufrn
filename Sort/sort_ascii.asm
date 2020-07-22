# Samuel Cavalcanti Matricula 20160108682

.data
	     #   0  1   2  3  4   5   6   7  8   9  10  11
	A: .word 3, 9, 17, 2, 51, 37, 13, 4, 8, 41, 67, 10 
	jumpLine : .asciiz "\n"
	space: .asciiz " "
	# cada endereco tem 4 bytes 
	size: .word 12
	initialPos: .word 0
	
	
.text 
	main:	
	
		add $s1, $zero, 11 # tamanho de A -1 
		
		add $s2, $zero, 11 # posicao ao qual ficara o maior valor, comeca na ultima
		
		move $s0, $zero
	
		begin_for:
		bgt $s0, $s1, exit_for #enquando $s0 for menor que $s1 fica dentro do for, caso o contrario vai para exit for
	 		
	 		
	 		move $a0, $s1 # getTheBiggerValueOfA rescebe como paramentro o endereco maximo comeca em 11 e vai caindo, 11,10,9 ...
	 		jal getTheBiggerValueOfA
	 	
	 		
	 		move $a0, $v0 # a0 index de maior valor,
	 		move $a1, $v1 # a1 maior valor,
	 		move $a2, $s1 # a2 index a ser substituido
	 		jal swap  
	 				
	 		
	 		
	 		
	 		sub $s1, $s1, 1 # encremeta o resgistrador t1
	 	
	 	
		j begin_for
		
		exit_for:# quando $s1 for menor $s0 , printa o array e sai do programa 
		
		
		jal printA # mostrar o array A ordenado
		
		
	
		
		jal exitProgram # sair do programa 
		
		

	
	
	
	getValueOfA:
		mul $a0, $a0, 4 # tem que pular em 4 bytes para pegar o endereco 
	 		
	 	lw $v0 , A($a0) # carrega a word do endereco $t9 no regitrador $v0
	 	
	 	jr $ra # volta para a funcao que a chamou
	
	
	setValueInA: # rescebe como paramentro o index e valor a ser amazenado
		mul $a0, $a0, 4  # tem que pular em 4 bytes para pegar o endereco 
		
		sw $a1, A($a0)
		
		jr $ra # volta para a funcao que a chamou
	
	
	getTheBiggerValueOfA:
		
		move $t1, $zero # inicia o iterador com 0
		
		move $t2, $a0 # dita ate onde vai a busca, no comeco he 11 depois 10, depois 9 ... ate 2
		
		move $t3, $ra # nao esquecer o caminho de volta
		
		move $a0, $t1 # argumento de entrada para get value
	 	jal getValueOfA # retorna o valor do index $a0 no registrador v0
	 	
	 	move $t4, $zero # incializa o index de maior valor
	 	
	 	move $t5, $v0 # inicializa o maior valor com o primeiro valor do vetor 
	 		
		begin_for_2:
		bgt $t1, $t2, exit_for_2
	 			 		
	 		move $a0, $t1 # getValueOfA rescebe como argumento um index: 0 ou 1 ou 2 ou 3 ... ou 11 
	 		jal getValueOfA
	 		
	 		
	 		move $a0, $t4 # index do maior valor atual
	 		
	 		move $a1, $t5 # rescebe o maior valor atual
	 		
	 		move $a2, $t1 # index atual
	 		
	 		move $a3, $v0 # valor atual
	 		
	 		jal greaterThan # troca o maior valor atual pelo valor atual se o atual for maior
	 		
	 		move $t4 ,$v0 # armazena o index do maior valor atual
	 		move $t5 ,$v1 # armazena o maior valor atual
	 				
	 		
	 		addi $t1, $t1, 1 # encremeta o resgistrador t1
	 	
	 	
			j begin_for_2
		
		
		exit_for_2:	
		
		
	 		
		
		
		
		move $v0, $t4 # joga no registrador de saida o index do maior valor atual
		
		move $v1, $t5 # joga no registrador de saida  o maior valor atual
		
		jr $t3 # volta para a funcao que a chamou
		
		
	greaterThan:
	 	
	 	
		bgt $a1, $a3, a1GreaterThanA3
			move $v0, $a2 # a3 maior que a1
			move $v1, $a3
			jr $ra # volta para a funcao que a chamou
		
		a1GreaterThanA3:
		
		move $v0, $a0  # a1 maior que a3
		move $v1, $a1
		
		jr $ra # volta para a funcao que a chamou
		
		
		
	
	println:
		move $a2 $a0
		move $a3, $ra
		
		la $a0, jumpLine # carregando a label ResultMessage no registrador a0 , a0 he dos registradores lidos para executar uma syscall 	
		jal displayMessage
	
		
		move $a0, $a2
		jal printInteger
		
		jr $a3
		
	
	printInteger:
		li $v0, 1 # carregando o servico print int no registrador v0 
		syscall # chamando a syscall
		
		jr $ra # volta da onde veio
	
	
	displayMessage:
		li $v0, 4 # carregando o servico print string no registrador v0 
		syscall # chamando a syscall
		
		jr $ra # voltar para onde veio 
	
	
	swap:#a0 index de maior valor, a1 maior valor, a2 index a ser substituido
		
		move $t0, $a0
		move $t1, $a1
		
		move $t3, $ra  # nao esquecer o caminho de volta
		
		move $a0, $a2
		jal getValueOfA # retorna em $v0 o valor do index  $a0
	 	
	 	move $a0, $t0 # index do maior valor
	 	move $a1, $v0 # valor inferiro ou igual ao maior valor
	 	jal setValueInA # colocando o valor presente nas ultimas posicoes na posicao do maior valor
	 	
	 	move $a0, $a2 # index mais a direita que o index do maior valor
	 	move $a1, $t1 # valor da maior posicao
	 	jal setValueInA # colocando o maior valor nas ultimas posicoes
	 	 	
	 	jr $t3
	 	
	
	
	printA:
		move $t1, $zero # iterador t1 = 0
		
		add $t2, $zero, 11 # tamanho de A -1
		
		move $t3, $ra # nao esquecer o caminho de volta
		
		begin_for_3:
		bgt $t1, $t2, exit_for_3 # quando $t1 > $t2 entao sai do laco for e para no exit_for_3: 
	 			 		
			
			move $a0, $t1
			jal getValueOfA # pega o valor do array no index $a0 
	 			
	 		move $a0, $v0
	 		jal printInteger # mostra na tela o valor 
	 		
	 		la $a0, space # adiciona um " " espaco pra ficar bonitinho :D
	 		jal displayMessage
	 		
	 		addi $t1, $t1, 1 # encremeta o resgistrador t1
	 	
	 	
			j begin_for_3
		
		
		exit_for_3:
		
		jr $t3 # volta para onde foi chamada 
	
	
	exitProgram:
		li $v0,10 
		syscall
		
	

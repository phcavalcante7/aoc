.data
	input_trys: .asciiz "Entre com a quantidade total de tentativas: "
	pc_win: .asciiz "O computador venceu!\n"
	user_win: .asciiz "Parabens! Voce venceu!\n"
	above: .asciiz "Seu chute foi acima do numero secreto\n"
	below: .asciiz "Seu chute foi abaixo do numero secreto\n"
	
.text
.globl main

main:
	#Setting a random int between 1 - 10
	li $a1, 10	#Setting the max 
	li $v0, 42	#Random int
	syscall
	add $a0, $a0, 1	#Cant be zero
	move $t0, $a0	#keeping value key in t0
	
	#User setting number of trys
	li $v0, 4
	la $a0, input_trys
	syscall
	li $v0, 5
	syscall
	move $t1, $v0	#keeping numbers os try in t1
	
	j attemp 

attemp:
	li $v0, 5
	syscall			#user input
	move $t2, $v0
	beq $t2, $t0, win	#if try == key => win
	beq $t2, $zero, loss	#if try == 0 => exit code
	bgt $t2, $t0, above_f	#else if try > key => message above
	bgt $t0, $t2, below_f	#else (key > try) => below	
	
has_try:
	sub $t1, $t1, 1
	beq $t1, $zero, loss
	j attemp
	
win:
	li $v0, 4
	la $a0, user_win
	syscall	#output the user_win message 
	
	j finish	#Jump to finish and ends the program
	
loss:	
	li $v0, 4
	la $a0, pc_win	
	syscall
	
	j finish
	
finish:
	li $v0, 10
	syscall
	
above_f:
	li $v0, 4
	la $a0, above
	syscall	#output the above message
	
	j has_try
	
below_f:
	li $v0, 4
	la $a0, below
	syscall	
	
	j has_try
# Final Group Project - MIPS Cipher Program
# CS2640.02 - Computer Organization and Assembly Programming
# Group Members - Austin Maranan, Timothy Jo, Lushan Zhang, Jacob Ladd, Bryan Pacheco
# Description: Cipher program that retrieves a text from user and allows users to encrypt or decrypt text.

.include "cipherMacros.asm"

.data

#main menu
title: .asciiz "~~~~~ Caesar Cipher ~~~~~\n"
current_shift: .asciiz "\nCurrent shift: "
menu: .asciiz  "\n*** MENU ***\n (1) Encode\n (2) Decode\n (3) Modify shift\n (4) Exit program\n\nSelect option: "

#invalid input
invalid: .asciiz "\nInvalid Input: Please enter a number between 1-4\n"
line: .asciiz "\n------------------------------------------------\n"


text_prompt: .asciiz "Enter text: "
shift_prompt: .asciiz "Enter shift value: "
result_text: .asciiz "Result: "

new_line: .asciiz "\n"

buffer: .space 501

.text

main: 

	# auto set shift to 3, store in $s0
	addi $s0, $zero, 3

	print(title)

# menu loop
loop:

	print(current_shift)
	
	# print current shift value
	printInt($s0)

	print(menu)
	
	# get user option
	readInt($t0)	# save user option into $t0
	
	# branch depending on user option
	beq $t0, 1, encode
	beq $t0, 2, decode
	beq $t0, 3, shift
	beq $t0, 4, exit
	
	# jump back to loop if user option not 1-4
	print(line)
	print(invalid)
	print(line)
	j loop

# encrypts text	
encode:

	print(text_prompt)
	
	# read user string and store in $t1
	readStr(buffer)
	
	jal shift_loop
	
	j print_result
	
# decrypts text	
decode:
	
	# flip the sign of the shift
	mul $s0, $s0, -1
	
	print(text_prompt)
	
	# read user string and store in $t1
	readStr(buffer)
	
	jal shift_loop
	
	# flip back
	mul $s0, $s0, -1
	
	j print_result
	
shift_loop:
	
	lb $t2, 0($t1)		# load char from buffer
	beqz $t2, done		# exit if null terminated
	
	# check for lowercase
	li $t3, 'a'
	li $t4, 'z'
	blt $t2, $t3, next	# if char < 'a', skip shift
	bgt $t2, $t4, next	# if char > 'z', skip shift
		
	# shift char by shift ($s0)
	add $t2, $t2, $s0
		
	# wrap if beyond 'z'
	li $t5, 'z'
	ble $t2, $t5, check_below_a
		
	# wrap around by subtracting 26
	li $t6, 26
	sub $t2, $t2, $t6
	j check_below_a
	
		
check_below_a:
	# wrap if below 'a'
	li $t7, 'a'
	bge $t2, $t7, store
	
	# add 26 to wrap around 
	li $t6, 26
	add $t2, $t2, $t6
	
store:

	sb $t2, 0($t1)		# store shifted char back to buffer

next:

	addi $t1, $t1, 1
	j shift_loop

done:

	jr $ra

# determines the shift amount	
shift:
	
	# asks user for new shift value
	print(shift_prompt)
	
	# get user input for shift and store into $s0
	readInt($s0) 

	j loop
	
print_result: 
	
	print(result_text)
	print(buffer)
	print(new_line)
	
	j loop
	
exit:
	# exit program
	exit()

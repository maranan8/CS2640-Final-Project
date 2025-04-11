# Final Group Project - MIPS Cipher Program
# CS2640.02 - Computer Organization and Assembly Programming
# Group Members - Austin Maranan, Timothy Jo, Lushan Zhang, Jacob Ladd, Bryan Pacheco
# Description: Cypher program that retrieves a text from user and allows users to encrypt or decrypt text.

# print macro 
.macro print(%string)

	li $v0, 4
	la $a0, %string
	syscall
	
.end_macro


.data

title: .asciiz "~~~~~ Ceaser Cypher ~~~~~\n"
current_shift: .asciiz "\nCurrent shift: "
menu: .asciiz  "\n*** MENU ***\n (1) Encode\n (2) Decode\n (3) Modify shift\n (4) Exit program\n\n Select option: "
text_prompt: .asciiz "Enter text: "
shift_prompt: .asciiz "Enter shift value: "
result_text: .asciiz "Result: "

new_line: .asciiz "\n"

input: .space 132
output: .space 132

.text

main: 

	# auto set shift to 3, store in $s0
	addi $s0, $zero, 3

	print(title)

loop:

	print(current_shift)
	
	# print current shift value
	li $v0, 1
	move $a0, $s0
	syscall

	print(menu)
	
	# get user option
	li $v0, 5
	syscall
	move $t0, $v0 	# save user option into $t0
	
	# branch depending on user option
	beq $t0, 1, encode
	beq $t0, 2, decode
	beq $t0, 3, shift
	beq $t0, 4, exit
	j loop 	# jump back to loop if user option not 1-4
	
encode:

	print(text_prompt)
	
	# read user string and store in $t1
	li $v0, 8
	la $a0, input
	li $a1, 99
	syscall
	move $t1, $a0
	
	# TODO: need to make shift algoritm and store into output buffer 
	
	j print_result
	
decode:

	print(text_prompt)
	
	# read user string and store in $t1
	li $v0, 8
	la $a0, input
	li $a1, 99
	syscall
	move $t1, $a0
	
	# TODO: need to make reverse-shift algoritm and store into output buffer 
	
	j print_result
	
shift:
	
	print(shift_prompt)
	
	# get user input for shift and store into $s0
	li $v0, 5
	syscall
	move $s0, $v0

	j loop
	
print_result: 
	
	print(result_text)
	print(output)
	print(new_line)
	
	j loop
	
exit:
	# exit program
	li $v0, 10
	syscall
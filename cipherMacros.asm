# Final Group Project - MIPS Cipher Program
# CS2640.02 - Computer Organization and Assembly Programming
# Group Members - Austin Maranan, Timothy Jo, Lushan Zhang, Jacob Ladd, Bryan Pacheco
# Description: Macros used in cypher.asm

#prints string
.macro print(%string)
	li $v0, 4
	la $a0, %string
	syscall
.end_macro

#read string
.macro readStr(%buffer)
	li $v0, 8
	la $a0, %buffer
	li $a1, 99
	syscall
	move $t1, $a0
.end_macro

#reads integer: %register - which register to save to
.macro readInt(%register)
	li $v0, 5
	syscall
	move %register, $v0 
.end_macro

#print integer: %register - which register to print
.macro printInt(%register)
	li $v0, 1
	move $a0, %register
	syscall
.end_macro

#exit program
.macro exit()
	li $v0, 10
	syscall
.end_macro

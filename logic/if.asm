.data
	msg1:.asciiz"\nthen"
	msg2:.asciiz"\nelse"
.text 
main:
	#branch beq, bne, bgt, bge, blt, ble
	# branch op1, op2, label
	li $t1, 2
	li $t2, 2
	
	beq $t0, $t2, then:
	j else
	
then:
	li $v0, 4
	la $a0, msg1
	syscall
	j end

else:
	li $v0, 4
	la $a0, msg2
	syscall
	
end:
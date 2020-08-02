.data
	msg1:.asciiz"\ntype one number"
	msg2:.asciiz"\neven"
	msg3:.asciiz"\nodd"
.text 
main:
	li $v0 ,4
	
	#load address
	la $a0, msg1
	syscall
	
	li $v0 ,5
	syscall
	add $t1, $v0, 0

	rem $t0, $t1, 2
	beq $t0, 0, then:
	j else
	
then:
	li $v0, 4
	la $a0, msg2
	syscall
	j end

else:
	li $v0, 4
	la $a0, msg3
	syscall
	
end:
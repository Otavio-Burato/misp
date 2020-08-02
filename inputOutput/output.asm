.data

.text 
main:
	li $t1, 2
	li $t2, 2
	
	add $t0,$t1,$t2
	
	#write
	li $v0 ,1 #code 1: write int
	add $a0, $t0, 0
	syscall

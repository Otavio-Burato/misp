.data

.text 
main:
	# $t0(s) $t1(s0) $t2(v) $t3(t)
	li $t1, 0
	li $t2, 10
	li $t3, 25
	
	mul $t2, $t2, $t3
	add $t0, $t1, $t2
	
	li $v0, 1
	add $a0, $t0, 0
	syscall

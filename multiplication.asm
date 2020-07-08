.data

.text 
main:
	#load immediate var $t1 <- 10
	li $t1, 10
	li $t2, 2
	
	#multiplication $t0 <- $t1 + $t2
	mul $t0,$t1,$t2
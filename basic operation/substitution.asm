.data

.text 
main:
	#load immediate var $t1 <- 10
	li $t1, 10
	li $t2, 2
	
	#substitution $t0 <- $t1 + $t2
	sub $t0,$t1,$t2
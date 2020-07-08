.data

.text 
main:
	#load immediate var $t1 <- 10
	li $t1, 10
	li $t2, 2
	
	#division $t0 <- $t1 + $t2
	div $t0,$t1,$t2
.data

.text 
main:
	#load immediate var $t1 <- 10
	li $t1, 10
	li $t2, 2
	
	#addition $t0 <- $t1 + $t2
	add $t0,$t1,$t2
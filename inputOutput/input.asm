.data

.text 
main:
	#read
	li $v0 ,5 #code 5: read int
	syscall
	add $t1, $v0, 0

# Compute several Fibonacci numbers and put in array, then print
.data
arr: .word 1, 12, 0, -3, 99, 48, -17, -9, 20, 15         # "array" of words to contain arr values
size: .word  10             # size of "array" (agrees with array declaration)
prompt: .asciiz "How many Fibonacci numbers to generate? (2 <= x <= 19)"
.text

	la   $s0, arr        # load address of array
      	la   $s1, size        # load address of size variable
      	lw   $s1, 0($s1)      # load array size


	
bubbleSort:

	addi $t0, $zero, 0	# int i = 0
	addi $t1, $s1, -2 	# Used to check that 'i' is less than (arr.size - 1) 
	
	outerForLoop:		# for (i = 0; i < n-1; i++)
		
		addi $t2, $zero, 0	# int j = 0
		sub $t3, $t1, $t0	# Used to check that 'j' is less than (arr.size - 1 - i)
		innerForLoop:		# for (j = 0; j < n-1-i; j++)
		
		
			sll $t7, $t2, 2		# Multiply j by 4 to find arr[j], integer is size 4 bytes, word
			add $s2, $s0, $t7	# arr[j]
			addi $t8, $t7, 4 	# add for to look for index in array at j + 1
			add $s3, $s0, $t8	# address of arr[j+1]
			
			lw $a0, ($s2)		# value at arr[j]
			lw $a1, ($s3)		# value at arr[j+1]
			
			slt $t4, $a1, $a0	# equals 1 if arr[j+1] is less than arr[j]
			
			beq $t4,$zero, false	# if (arr[j+1] is not less than arr[j]) 
			
			true:
			
			jal swap		# swap arr[j+1] and arr[j], if arr[j+1] is less than arr[j]
			
			false:			# don't swap, continue to next loop
			
			
			beq $t2, $t3, endInnerForLoop	# if j = (arr.size - 1 - i), the finish for loop
			addi $t2, $t2, 1		# increment j for next iteration
			j innerForLoop			# jump to top of loop for next iteration
			
		endInnerForLoop:
		
		beq $t0, $t1, exit	# loop is finished and sorting is done
		addi $t0, $t0, 1	# increment j for next iteration
		j outerForLoop		# jump to top of loop
	

exit:

li $v0, 10
syscall

swap:
	add $t5, $a0, $zero	# temp = value at arr[j]
	sw $a1, ($s2)		# arr[j] = value at arr[j+1]
	sw $t5, ($s3)		# arr[j+1] = temp
	
	jr $ra			# return












.text
addi $1, $0, 500	#$1 = 500		-addi
addi $2, $0, 250	#$2 = 250		-addi
add $3, $1, $2		#$3 = 750		-add
addiu $4, $3, 750	#$4 = 1500		-addiu
addu $5, $4, $1		#$5 = 2000		-addu
and $6, $5, $4		#$6 = 1488		-and
andi $7, $5, 1000	#$7 = 960		-andi
nor $8, $4, $5		#$8 = -2013		-nor
xor $9, $4, $5		#$9 = 524		-xor
xori $10, $4, 1000	#$10 = 1588		-xori
or $11, $4, $5		#$11 = 2012
ori $12, $3, 400	#$12 = 1022
slt $13, $2, $1		#$13 = 1
slti $14, $2, 6000	#14 = 1
sll $15, $4, 2		#15 = 6000
srl $16, $5, 4		#16 = 125
sra $17, $6, 5		#17 = 46
sub $18, $9, $8		#18 = 2537
subu $19, $8, $6	#19 = -3501
beq $13, $14, skip1	#branch
addi $1, $1, -500	#should not compute
skip1:
bne $13, $8, skip2	#branch
addi $1, $1, -500	#should not compute
skip2:
addi $20, $0, 268500992
sw $18, 0($20)		#store 2357 in mem
lw $21, 0($20)		#load from mem
j skip3
addi $1, $1, -500	#should not compute
skip3:

halt



#lui $8, 5000		#$8 = 327680000		-lui

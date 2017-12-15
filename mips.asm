li $1, 1
li $2, 2
li $3, 3
li $4, 4
li $5, 5
li $6, 6
li $7, 7
li $8, -8
li $9, -9
li $10, -10
li $11, -11
li $12, -12
li $13, -13
li $20, 20
li $21, 21
li $22, 22
li $23, 23
mult $2, $3
mfhi $16
mflo $17
mult $4, $8
mfhi $18
mflo $17
mult $8, $9
mfhi $16
mflo $17
######
multu $2, $3
mfhi $16
mflo $17
multu $4, $8
mfhi $18
mflo $17
multu $8, $9
mfhi $16
mflo $17
########3
div $5, $2
mfhi $16
mflo $17
div $9, $4
mfhi $18
mflo $17
div $13, $8
mfhi $16
mflo $17
divu $5, $2
mfhi $16
mflo $17
divu $9, $4
mfhi $18
mflo $17
divu $13, $8
mfhi $16
mflo $17
#####
li $1, 15
li $2, 4
mult $1,$2
mfhi $3
mflo $4
mult $3, $4
mfhi $5
mflo $6
mthi $2
mfhi $10
mtlo $1
mflo $11
mult $1, $2
div $1, $2
mfhi $12
mflo $13
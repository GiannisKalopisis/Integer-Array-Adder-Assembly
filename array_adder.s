	.data

array:  .byte 58, 81, 96, 42, 121, 44, 115, 74
.byte 124, 22, 34, 9, 10, 57, 11, 80
.byte 71, 106, 111, 13, 102, 12, 14, 22
.byte 59, 65, 8, 57, 48, 9, 89, 106
.byte 91, 57, 20, 84, 101, 7, 31, 98
.byte 29, 65, 107, 39, 122, 118, 120, 65
.byte 96, 103, 78, 70, 115, 93, 93, 46
.byte 30, 101, 104, 78, 111, 65, 56, 74
.byte 122, 76, 30, 96, 83, 61, 66, 112
.byte 126, 45, 24, 120, 35, 16, 57, 4
.byte 119, 8, 74, 106, 101, 39, 24, 3
.byte 13, 0, 81, 124, 65, 9, 70, 60
.byte 85, 100, 28, 40, 34, 94, 24, 32
.byte 11, 48, 25, 46, 64, 82, 50, 55
.byte 90, 125, 33, 63, 36, 58, 66, 49
.byte 58, 19, 45, 124, 28, 115, 56, 113
.byte 88, 84, 25, 122, 50, 50, 26, 61
.byte 98, 51, 107, 35, 6, 30, 90, 96
.byte 27, 124, 32, 63, 54, 98, 113, 112
.byte 118, 30, 108, 18, 18, 36, 4, 106
.byte 120, 29, 100, 42, 79, 126, 103, 50
.byte 50, 83, 85, 56, 113, 47, 24, 12
.byte 43, 56, 75, 97, 27, 60, 82, 17
.byte 91, 62, 35, 109, 99, 39, 87, 91
.byte 69, 59, 6, 20, 57, 109, 70, 107
.byte 64, 27, 35, 49, 75, 60, 61, 118
.byte 116, 9, 88, 15, 69, 42, 32, 32
.byte 104, 68, 13, 75, 107, 100, 39, 48
.byte 31, 45, 69, 89, 26, 11, 68, 91
.byte 39, 104, 12, 114, 36, 74, 104, 24
.byte 83, 64, 40, 24, 106, 72, 57, 83
.byte 12, 70, 30, 120, 43, 69, 40, 74
.byte 114, 109, 35, 13, 121, 104, 104, 32
.byte 80, 116, 18, 116, 62, 122, 12, 17
.byte 59, 52, 42, 37, 125, 99, 120, 9
.byte 41, 23, 1, 84, 92, 42, 31, 79
.byte 23, 66, 92, 16, 42, 68, 48, 122
.byte 56, 66, 110, 119, 61, 123, 8, 120
.byte 47, 50, 29, 44, 21, 22, 54, 63
.byte 45, 55, 19, 9, 97, 50, 88, 121
.byte 117, 52, 9, 31, 120, 58, 26, 49
.byte 124, 8, 40, 57, 3, 48, 49, 51
.byte 99, 79, 95, 120, 101, 21, 55, 18
.byte 77, 75, 27, 46, 125, 116, 39, 114
.byte 40, 49, 18, 33, 107, 44, 82, 103
.byte 52, 122, 33, 56, 42, 82, 107, 13
.byte 33, 74, 6, 6, 96, 61, 24, 45
.byte 8, 52, 91, 6, 40, 3, 120, 80
.byte 52, 10, 113, 31, 54, 67, 6, 107
.byte 61, 39, 35, 104, 122, 14, 117, 27
.byte 88, 123, 34, 56, 57, 58, 101, 65
.byte 110, 65, 71, 22, 68, 64, 103, 120
.byte 74, 88, 23, 1, 28, 29, 108, 89
.byte 69, 15, 65, 63, 29, 55, 90, 117
.byte 50, 124, 46, 107, 55, 19, 45, 37
.byte 84, 116, 60, 24, 52, 35, 16, 127
.byte 123, 39, 0, 23, 69, 108, 113, 10
.byte 123, 50, 73, 24, 105, 35, 13, 28
.byte 32, 59, 7, 87, 79, 52, 124, 35
.byte 41, 56, 60, 93, 91, 76, 92, 87
.byte 116, 92, 110, 57, 72, 95, 67, 67
.byte 18, 12, 91, 123, 47, 105, 23, 79
.byte 36, 31, 38, 115


mask1: .byte 0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00
mask2: .byte 0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF
mask3: .byte 0xFF,0xFF,0xFF,0xFF


#sum = 7bc5 / 31685

mes:    .asciiz "Sum: "		; message
		
CONTROL: .word32 0x10000
DATA:    .word32 0x10008

	.text
	
	#r16 = number of loops
	#r18 = sum
	#r19 = i
	#r22 = current
	
	#for printing at the end
	lwu $t8,DATA($zero)	; $t8 = address of DATA register
	lwu $t9,CONTROL($zero)	; $t9 = address of CONTROL register
	
	#load masks 
	ld r5,mask1($zero)
	ld r6,mask2($zero)

	
main:

	
	ld r22, array(r19)	#load first memory word with 8 numbers
	daddi r16, $zero, 7	#number of loops
	
	
L1:
	
	daddi r19,r19,8
	and r20,r22,r5
	and r21,r22,r6
	dsrl r21,r21,8
	daddu r18, r18, r20
	daddu r18, r18, r21
	
	ld r22,array(r19)
	
	daddi r19,r19,8
	and r20,r22,r5
	and r21,r22,r6
	dsrl r21,r21,8
	daddu r18, r18, r20
	daddu r18, r18, r21
	
	#daddi r16,r16,-1
	ld r22,array(r19)
	
	daddi r19,r19,8
	and r20,r22,r5
	and r21,r22,r6
	dsrl r21,r21,8
	daddu r18, r18, r20
	daddu r18, r18, r21

	ld r22,array(r19)
	
	daddi r19,r19,8
	and r20,r22,r5
	and r21,r22,r6
	dsrl r21,r21,8
	daddu r18, r18, r20
	daddu r18, r18, r21
	
	#daddi r16,r16,-1
	ld r22,array(r19)
	
	daddi r19,r19,8
	and r20,r22,r5
	and r21,r22,r6
	dsrl r21,r21,8
	daddu r18, r18, r20
	daddu r18, r18, r21

	ld r22,array(r19)
	
	daddi r19,r19,8
	and r20,r22,r5
	and r21,r22,r6
	dsrl r21,r21,8
	daddu r18, r18, r20
	daddu r18, r18, r21
	
	#daddi r16,r16,-1
	ld r22,array(r19)
	
	daddi r19,r19,8
	and r20,r22,r5
	and r21,r22,r6
	dsrl r21,r21,8
	daddu r18, r18, r20
	daddu r18, r18, r21

	ld r22,array(r19)
	
	daddi r19,r19,8
	and r20,r22,r5
	and r21,r22,r6
	dsrl r21,r21,8
	daddu r18, r18, r20
	daddu r18, r18, r21

	ld r22,array(r19)
	
	daddi r19,r19,8
	and r20,r22,r5
	and r21,r22,r6
	dsrl r21,r21,8
	daddu r18, r18, r20
	daddu r18, r18, r21
	
	daddi r16,r16,-1
	ld r22,array(r19)
	
	
	beqz r16,DONE
	
	j L1

DONE:
	
	#find final sum
	ld r5,mask3($zero)
	
	daddi r13,$zero,32
	and r15,r18,r5
	dsrlv r18,r18,r13
	
	daddu r15,r15,r18
	
	dsrl r5,r5,16
	and r18,r15,r5
	dsrl r15,r15,16
	
	daddu r18,r18,r15
	
	
	#
	#print result
	#

	daddi $v0,$zero,4       ; set for ascii output
	daddi $t1,$zero,mes
	sd $t1,0($t8)           ; write address of message to DATA register
	sd $v0,0($t9)           ; make it happen


	daddi $v0,$zero,1	; set for unsigned integer output
	sd r18,0($t8)           ; write integer to DATA register
	sd $v0,0($t9)           ; write to CONTROL register and make it happen

	halt
	

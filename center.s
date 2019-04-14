.text
			.global _start

_start:
			LDR R5, =FIXVALUE	// R5 point to the FIXVALUE location
			LDR R4, =RESULT     // R4 points to the result location
			LDR R2, [R4, #4]    // R2 holds the number of element in the list
			ADD R3, R4, #8      // R3 points to the first number
			LDR R0, [R3]        // R0 holds the first number in the list


LOOP: 		SUBS R2, R2, #1     // decrement the loop counter
			BEQ AVERAGE         // end loop if counter has reached 0
			ADD R3, R3, #4      // R3 points to next number in the list
			LDR R1, [R3]        // R1 holds the next number in the list
			ADD R0,R0,R1        // R0 contains the summation of the elements
			B LOOP              // branch back to the loop


AVERAGE: 	LDR R2, [R4, #4]    // R2 holds the number of element in the list
			CLZ R2,R2			// overwritten R2 to number of zeros to the left of the number of elements
			LDR R1, [R5]		// R1 takes the value of the FIXVALUE (31)

			SUB R2, R1, R2		// R2 overwriten to give the number of zeros to the right of the number of elements (by how many we want to shift to do our div.)
			LSR R0, R0,R2       //R0 holds the average(the division has been made by shifting)
			
			LDR R2, [R4, #4]    // R2 holds the number of element in the list
			STR R0, [R4]        // store the average to the memory location RESULT
			ADD R3, R4, #8      // R3 points to the first number
			LDR R6,[R3]			// R6 holds the first element
			SUB R6, R6,R0		// R6 now hold the value of the average substracted from the first element 
			STR R6,[R3]			// the first element is now updated and stored iin the memory
			
CENTER:		SUBS R2, R2, #1     // decrement the loop counter
			BEQ END             // end loop if counter has reached 0
			ADD R3, R3,#4		// R3 points to the next element in the list
			LDR R6,[R3]			// R6 holds the value of the next element
			SUB R6, R6,R0		// R6 now hold the value of the average substracted from the first element 
			STR R6,[R3]			// the first element is now updated and stored in the memory(in the list)
			B CENTER			// back to the loop
			


END: 		B END               // infinite loop!

RESULT:		.word 0           	// memory assigned for the result location
N: 			.word 16           	//number of entries in the list
NUMBERS: 	.word 5,6,10,12  		// the list data
            .word 3,7,13,2
			.word 3,7,13,2
			.word 3,7,13,2
FIXVALUE:	.word 31

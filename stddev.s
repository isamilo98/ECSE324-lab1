.text
			.global _start

_start:
			LDR R8, =STANDEV	  // R8 points to the standard deviation result
			LDR R4, =MINRESULT    // R4 points to the min result location
			LDR R5, =MAXRESULT    // R5 points to the max result location
			LDR R2, [R4, #8]      // R2 holds the number of element in the list
			ADD R3, R4, #12       // R3 points to the first number
			LDR R0, [R3]          // R0 holds the first number in the list
			


MINLOOP: 		SUBS R2, R2, #1     // decrement the loop counter
			    BEQ TRANSITION      // end loop if counter has reached 0
			    ADD R3, R3, #4      // R3 points to next number in the list
			    LDR R1, [R3]        // R1 holds the next number in the list
			    CMP R1, R0          // check if it is greater than the minimum(if the value of R1 is smaller?)
			    BGE MINLOOP         // if no, branch back to MINLOOP
			    MOV R0, R1          // if yes, update the current min(R0 will always contain the minimum value)
			    B MINLOOP           // branch back to the MINLOOP


TRANSITION:     STR R0, [R4]        // store the (min_value) to the memory location MINRESULT
				
				LDR R2, [R4, #8]    // R2 holds the number of element in the list
				ADD R3, R4, #12      // R3 points to the first number
				LDR R0, [R3]        // R0 holds the first number in the list

MAXLOOP: 		SUBS R2, R2, #1     // decrement the loop counter
			    BEQ DONE            // end loop if counter has reached 0
			    ADD R3, R3, #4      // R3 points to next number in the list
			    LDR R1, [R3]        // R1 holds the next number in the list
			    CMP R0, R1          // check if it is greater than the maximum(if the value of R0 is greater than R1)
			    BGE MAXLOOP            // if no, branch back to MAXLOOP
			    MOV R0, R1         	 // if yes, update the current max(will always contain the max value)
			    B MAXLOOP           // branch back to the MAXlOOP
				


DONE: 		LDR R7,[R4]        // store the max_value to the memory location MAXRESULT
			

			SUB R6, R0, R7		// substract R7(MINVALUE) from R0(MAXVALUE) and place it in R6
			LSR	R6, R6, #2		// shift the value of R6 to the right by 2--> divides by 4
			STR R6, [R8]        //STORE the standard deviation


END: 		B END               // infinite loop!

STANDEV:		.word 0
MINRESULT:		.word 0           	// memory assigned for the result location
MAXRESULT:		.word 0           	// memory assigned for the result location
N: 				.word 7           	//number of entries in the list
NUMBERS: 		.word 1,2,3,4  		// the list data
            	.word 5,6,7

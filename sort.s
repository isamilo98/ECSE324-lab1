.text
			.global _start




_start: LDR R6, =N     // R6 points to the number of elements
		LDR R5, [R6]    // R5 holds the number of element in the list. second counter
		LDR R9, [R6]	// the first counter(how many time we go through all the loop)

BEGINNING:	SUBS R9, R9,#1 //decreases the first counter
			BEQ END        //tcheck if R9 is equal to 0
			LDR R5, [R6]    // R5 holds the number of element in the list. reset his initial value
			ADD R1, R6, #4      // R1 points to the first number
			ADD R2, R6, #8      // R2 points to the second number
			LDR R3, [R1]        // R3 holds the first number in the list
			LDR R4,[R2]        // R4 holds the seconder number in the list
			SUBS R5, R5, #1     //decrease counter
			CMP R3, R4			// compare R4(2nd ele.) and R3(1st ele.). R4 greater than R3?
			BGE SWAP      		//if no. go to swap. if yes go to loop
			


LOOP: 		SUBS R5, R5, #1     // decrement the loop counter
			BEQ BEGINNING            // end loop if counter has reached 0
			ADD R1, R1, #4      // R1 points to the first number
			ADD R2, R2, #4      // R2 points to the second number
			LDR R3, [R1]        // R3 holds the next number in the list
			LDR R4,[R2]        // R4 holds the seconder number in the list
			CMP R3, R4          // compare R4(2nd ele.) and R3(1st ele.). R4 greater than R3?
			BGE SWAP           // if no, go to swap
			B LOOP          // if yes, back to loop

SWAP: 		MOV R8, R3      //move the content of R3 in a temporary register 
	  		MOV R3, R4      //overwrite the R3 by R4
	  		MOV R4, R8      //change the value of R4 by R8
	  		STR R3, [R1]    //store in the memory
	  		STR R4, [R2]    //store in the memory
	  		B LOOP          // back to loop
		 		


END: 		B END               // infinite loop!


N: 			.word 7           	//number of entries in the list
NUMBERS: 	.word 10,15,1,8  		// the list data
            .word 16,2,0

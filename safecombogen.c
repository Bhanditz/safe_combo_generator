#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool isdescending(int x, int y, int z){
/* 
 * Receives the three integers for the combination and tests to determine
 * if they are in a descending sequence. Returns true if they are and 
 * false if they are not.
 */
	if ((x > y) && (y > z)){
		return true;
	}else{ 
		return false;
	}
}
bool isascending(int x, int y, int z){
/* 
 * Receives the three integers for the combination and tests to determine
 * if they are in an ascending sequence. Returns true if they are and 
 * false if they are not.
 */
	if ((x < y) && (y < z)){
		return true;
	}else{ 
		return false;
	}
}

int main(){
	int min = 0;
	int max = 99;
	int num = 50;
	
	// Initializing the random number generator.
	time_t t;
	srand((unsigned) time(&t));

	// 
	for( ; num > 0; ){
		// Generating random numbers for each combination element
		int first = rand()%(max-min+1)+min;
		int second = rand()%(max-min+1)+min;
		
		int third = rand()%(89-11)+11; // Eliminating 90-10 from selection for the third.
		
		if(second == first){  
			// Eliminating possible duplicates & regenerating until they don't match.
			second = rand()%(max-min+1)+min;
		}
		
		while((third == second) || (third == first)){	
			// Eliminating possible duplicates & regenerating until they don't match.
			third = rand()%(89-11)+11;  // Same as before, eliminating 90-10.
		}

// Finally Testing for Ascending and Descending and outputting results.
		if( isascending(first, second, third) || isdescending(first, second, third)){
//			printf( "Rejected: %d-%d-%d\n",first,second,third);
		}else{
			printf("%d-%d-%d\n",first,second,third);
			num--; 
		}
	}
	return 0;
}

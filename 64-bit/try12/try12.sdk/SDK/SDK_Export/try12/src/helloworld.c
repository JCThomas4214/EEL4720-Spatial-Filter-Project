#include <stdio.h>
#include "platform.h"
#include "PROJECT12_REDUCED.h"
#include "PROJECT11_TIMER.h"
#include "coeR.h"
#include "coeP.h"
#include "coeQ.h"

#define PROJECT 0x7A000000
#define TIMER 0x6BE00000

int snip(int banana) {
	return banana / 65536;
}

int backW(int banana) {
	int count = 2;
	int n = banana, reverse = 0;
	while (count != 0)
	   {

		reverse = reverse * 65536;
	    if (n%65536 != 0) {
	    	reverse = reverse + n%65536;
	    }
	    else {
	    	if (n == 0) {
	    		return reverse;
	    	}
	    }
	    n = n/65536;
	    count--;
	   }
	return reverse;
}

void parseArr(int* array1, int* outArray) {
	int j = 0, k = 0;
	unsigned int tmp, tmpMod, holder;

	int* outArrayTmp = outArray;

	for (k = 0; k < 16256; k++) {
			tmp = *(array1 + k);
		holder = 0;
		for (j = 0;j < 4; j++) {
			tmpMod = tmp % 256;
			*(outArrayTmp + holder) = tmpMod;
			tmp = tmp / 256;
			holder++;
		}
		outArrayTmp = outArrayTmp + 4;
	}
}

int main()
{
	init_platform();
    int i = 0;
    int o = 0;
//    int done = 0;
    int hwOutput[8192];
    int hwOutput2[8192];

    int sum = 0;
    int final = 0;
    int ARMOutput[65024];

    int bramr[65024];
    int bramp[65024];
    int bramq[65024];

    //Reset the hardware core.
    PROJECT12_REDUCED_mWriteSlaveReg0(PROJECT, 0, 0x00000001);
    PROJECT12_REDUCED_mWriteSlaveReg0(PROJECT, 0, 0x00000000);

    parseArr(bromr, bramr);
    parseArr(bromp, bramp);
    parseArr(bromq, bramq);

    PROJECT11_TIMER_mWriteSlaveReg0(TIMER, 0, 0x00000001);
    PROJECT11_TIMER_mWriteSlaveReg0(TIMER, 0, 0x00000000);

    PROJECT11_TIMER_mWriteSlaveReg1(TIMER, 0, 0x00000001);
    for (o = 0; o < 65024; o++) {
    	sum = ((-1)*bramr[o]+(-1)*bramr[o+1]+(-1)*bramr[o+2]+
    			(-1)*bramp[o]+(9)*bramp[o+1]+(-1)*bramp[o+2]+
    			(-1)*bramq[o]+(-1)*bramq[o+1]+(-1)*bramq[o+2]);
    	final = sum/9;

    	if (final >= 0) {
    		ARMOutput[o] = final;
    	}
    	else {
    		ARMOutput[o] = 0;
    	}
    }
    PROJECT11_TIMER_mWriteSlaveReg1(TIMER, 0, 0x00000000);
    double ARM_clocks = PROJECT11_TIMER_mReadSlaveReg4(TIMER, 0);

    //Send go signal to hardware
    PROJECT12_REDUCED_mWriteSlaveReg1(PROJECT, 0,0x00000001);
    PROJECT12_REDUCED_mWriteSlaveReg1(PROJECT, 0, 0x00000000);

    //wait for 'done' signal from the core
 	int done = PROJECT12_REDUCED_mReadSlaveReg2(PROJECT, 0);
  	while(done==0)
  	{
  		done = PROJECT12_REDUCED_mReadSlaveReg2(PROJECT, 0);
  		printf("the done is %d\n", done);
  	}

    //Read the output BRAM result.
    PROJECT12_REDUCED_mWriteSlaveReg7(PROJECT, 0, 0x00000001);
    int tmp = 0, tmp2 = 0;
    for(i=0;i<8128;i++)
    	{
    		if (i%32 != 31) {
    			PROJECT12_REDUCED_mWriteSlaveReg6(PROJECT,0,i);
    			tmp = PROJECT12_REDUCED_mReadSlaveReg9(PROJECT,0);
    			tmp2 = PROJECT12_REDUCED_mReadSlaveReg10(PROJECT,0);
    			hwOutput[i] = tmp;
    			hwOutput2[i] = tmp2;
    		}
    		else {
    			PROJECT12_REDUCED_mWriteSlaveReg6(PROJECT,0,i);
    			tmp = PROJECT12_REDUCED_mReadSlaveReg9(PROJECT,0);
    			tmp2 = PROJECT12_REDUCED_mReadSlaveReg10(PROJECT,0);
    			tmp2 = backW(tmp2);
    			hwOutput2[i] = snip(tmp2);
    			hwOutput[i] = tmp;
    		}
    	}




//To check the contents on the input BRAM Arrays
/*
  	for (o = 65020; o < 65024; o++) {
    	printf("%02x\n",bramr[o]);
    }
    printf("Last pix R\n");
    for (o = 65020; o < 65024; o++) {
    	printf("%02x\n",bramp[o]);
    }
    printf("Last pix P\n");
    for (o = 65020; o < 65024; o++) {
    	printf("%02x\n",bramq[o]);
    }
    printf("Last pix Q\n");
*/
//To check the content of the output ARM Array

    double timing = ARM_clocks/100000000;
    printf("How many FPGA clocks elapsed for ARM processing: %f seconds\n", timing);
    i = 1;
    for (o = 0; o < 65024; o = o+4) {
    	if (i%64 == 0) {
    		printf("%02x%02x\n",ARMOutput[o+1],ARMOutput[o]);
    		i++;
    	}
    	else {
    		printf("%02x%02x%02x%02x\n",ARMOutput[o+3],ARMOutput[o+2],ARMOutput[o+1],ARMOutput[o]);
    		i++;
    	}
    }

//To check the contents of the hwOutput Array

    double fpga_clks = PROJECT12_REDUCED_mReadSlaveReg19(PROJECT, 0);
    timing = fpga_clks/100000000;
    printf("How many clocks for FPGA: %f seconds\n", timing);
    for(o=0; o < 8128; o++) {
    	if (o%32 == 31) {
    		printf("%08x\n",hwOutput[o]);
    		printf("%04x\n",hwOutput2[o]);
    	}
    	else {
    		printf("%08x\n",hwOutput[o]);
    		printf("%08x\n",hwOutput2[o]);
    	}
    }


    cleanup_platform();
    return 0;
}

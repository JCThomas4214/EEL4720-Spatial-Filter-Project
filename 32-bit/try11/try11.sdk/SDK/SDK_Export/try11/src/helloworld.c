#include <stdio.h>
#include "platform.h"
#include "PROJECT11_REDUCED.h"
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
	int count = 4;
	int n = banana, reverse = 0;
	while (count != 0)
	   {

		reverse = reverse * 256;
	    if (n%256 != 0) {
	    	reverse = reverse + n%256;
	    }
	    else {
	    	if (n == 0) {
	    		return reverse;
	    	}
	    }
	    n = n/256;
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
    int hwOutput[16256];

    int sum = 0;
    int final = 0;
    int ARMOutput[65024];

    int bramr[65024];
    int bramp[65024];
    int bramq[65024];

    //Reset the hardware core.
    PROJECT11_REDUCED_mWriteSlaveReg0(PROJECT, 0, 0x00000001);
//    int reset = PROJECT11_REDUCED_mReadSlaveReg0(PROJECT, 0);
//    printf("the reset is %d\n", reset);
    PROJECT11_REDUCED_mWriteSlaveReg0(PROJECT, 0, 0x00000000);
//    reset = PROJECT11_REDUCED_mReadSlaveReg0(PROJECT, 0);
//    printf("the reset is %d\n", reset);

//    done = PROJECT11_REDUCED_mReadSlaveReg2(PROJECT, 0);
//    printf("the done is %d\n",done);

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
    int ARM_clocks = PROJECT11_TIMER_mReadSlaveReg4(TIMER, 0);

    //Send go signal to hardware
    PROJECT11_REDUCED_mWriteSlaveReg1(PROJECT, 0,0x00000001);
//    int go = PROJECT11_REDUCED_mReadSlaveReg1(PROJECT, 0);
//    printf("the go is %d\n",go);

    PROJECT11_REDUCED_mWriteSlaveReg1(PROJECT, 0, 0x00000000);
//    go = PROJECT11_REDUCED_mReadSlaveReg1(PROJECT, 0);
//    printf("the go is %d\n",go);

    //wait for 'done' signal from the core
//    done= PROJECT11_REDUCED_mReadSlaveReg2(PROJECT, 0);


//    printf("the done is %d\n",done);

    //Read the output BRAM result.
    PROJECT11_REDUCED_mWriteSlaveReg7(PROJECT, 0, 0x00000001);
    int tmp = 0;
    for(i=1;i<=16256;i++)
    	{
    		if (i%64 != 0) {
    			PROJECT11_REDUCED_mWriteSlaveReg6(PROJECT,0,i);
    			tmp = PROJECT11_REDUCED_mReadSlaveReg9(PROJECT,0);
    			hwOutput[i] = backW(tmp);
    		}
    		else {
    			PROJECT11_REDUCED_mWriteSlaveReg6(PROJECT,0,i);
    			tmp = PROJECT11_REDUCED_mReadSlaveReg9(PROJECT,0);
    			tmp = backW(tmp);
    			hwOutput[i] = snip(tmp);
    		}
    	}

    int fpga_clks = PROJECT11_REDUCED_mReadSlaveReg19(PROJECT, 0);
    printf("How many clocks for FPGA: %d\n", fpga_clks);
    printf("How many FPGA clocks elapsed for ARM processing: %d\n", ARM_clocks);

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
    /*
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
    */
//To check the contents of the hwOutput Array
/*    for(o=1; o <= 16256; o++) {
    	if (o%64 == 0) {
    		printf("%04x\n",hwOutput[o]);
    	}
    	else {
    		printf("%08x\n",hwOutput[o]);
    	}
    }
*/

    cleanup_platform();
    return 0;
}

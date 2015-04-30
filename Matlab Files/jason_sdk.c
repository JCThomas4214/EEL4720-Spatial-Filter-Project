/*
 * Copyright (c) 2009-2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */


#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "project_core.h"
#include <sys/time.h>
#include <time.h>
#include <math.h>
#define PROJECT_CORE_BASE_ADDRESS 0x76E00000

typedef unsigned long   Xuint32;    /**< unsigned 32-bit */


/*
--Essential Registers
Slave Register Declaration;
Slave Reg 0: RESET (Write)
Slave Reg 1: GO (Write)
Slave Reg 2: DONE (Read)
Slave Reg 3: BRAM OUT (Lower 32 Bits) (Read)
Slave Reg 4: BRAM OUT (Middle 32 Bits) (Read)
Slave Reg 5: BRAM OUT (Top 8 Bits) (Read)
Slave Reg 6: BRAM OUT ADDR (Write)
Slave Reg 7: BRAM OUT ENABLE (Write)
Slave Reg 8: BRAM OUT RE/WE (Write)
--Unimportant Registers
Slave Reg 9: BRAM R ADDR IN (Write)
Slave Reg 10: BRAM R DATA IN (Lower 32 Bits) (Write)
Slave Reg 11: BRAM R DATA IN (Middle 32 Bits) (Write)
Slave Reg 12: BRAM R DATA IN (Top 8 Bits) (Write)
Slave Reg 13: BRAM IN Write Enable (Write)
Slave Reg 14: BRAM IN Enable (Write)
Slave Reg 15: BRAM P ADDR IN (Write)
Slave Reg 16: BRAM P DATA IN (Lower 32 Bits) (Write)
Slave Reg 17: BRAM P DATA IN (Middle 32 Bits) (Write)
Slave Reg 18: BRAM P DATA IN (Top 8 Bits) (Write)
Slave Reg 19: BRAM Q DATA IN (Lower 32 Bits) (Write)
Slave Reg 20: BRAM Q DATA IN (Middle 32 Bits) (Write)
Slave Reg 21: BRAM Q DATA IN (Top 8 Bits) (Write)
*/


int main(void)
{

	int done = 0;
	int i = 0;
	int j = 0;
	int pixel_int=904;
	int total_pixel=65024;
	int hwOutput1[904], hwOutput0[904];
	int hwText[65024];
init_platform();

print("Hello World\n\r");



//Reset the hardware core.
PROJECT_CORE_mWriteSlaveReg0(PROJECT_CORE_BASE_ADDRESS, 0, 0x00000001);
PROJECT_CORE_mWriteSlaveReg0(PROJECT_CORE_BASE_ADDRESS, 0, 0x00000000);

//Send go signal to hardware
PROJECT_CORE_mWriteSlaveReg1(PROJECT_CORE_BASE_ADDRESS, 0,0x00000001);
PROJECT_CORE_mWriteSlaveReg1(PROJECT_CORE_BASE_ADDRESS, 0, 0x00000000);

//wait for 'done' signal from the core
done= PROJECT_CORE_mReadSlaveReg2(PROJECT_CORE_BASE_ADDRESS, 0);

while(done==0)
{
    printf("the done is %d\n",done);
    //done= PROJECT_CORE_mReadSlaveReg2(PROJECT_CORE_BASE_ADDRESS, 0);
}
printf("the done is %d\n",done);


//Read the output BRAM result.

for(i=0;i<pixel_int;i++)
{
	PROJECT_CORE_mWriteSlaveReg6(PROJECT_CORE_BASE_ADDRESS,0,i);
    hwOutput1[i] = PROJECT_CORE_mReadSlaveReg5(PROJECT_CORE_BASE_ADDRESS,0);
    hwOutput0[i] = PROJECT_CORE_mReadSlaveReg4(PROJECT_CORE_BASE_ADDRESS,0) & PROJECT_CORE_mReadSlaveReg3(PROJECT_CORE_BASE_ADDRESS,0);
}


for(j=0;j<total_pixel;j+=9)
{
    for(i=0;i<pixel_int;i++)
    {
        hwText[j+0] = (hwOutput0[i]&0xFF);
        hwText[j+1] = ((hwOutput0[i]>>8)&0xFF);
        hwText[j+2] = ((hwOutput0[i]>>16)&0xFF);
        hwText[j+3] = ((hwOutput0[i]>>24)&0xFF);
        hwText[j+4] = ((hwOutput0[i]>>32)&0xFF);
        hwText[j+5] = ((hwOutput0[i]>>40)&0xFF);
        hwText[j+6] = ((hwOutput0[i]>>48)&0xFF);
        hwText[j+7] = ((hwOutput0[i]>>56)&0xFF);
        hwText[j+8] = (hwOutput1[i]&0xFF);
    }
}

FILE *out_file = fopen("C:\\Users\\NecroStar\\Desktop\\SDKout\\test.txt", "w"); // write only

      // write to file vs write to screen
      fprintf(stdout, "this is a test %d\n", 2); // write to screen
      fprintf(out_file, "SDK to Matlab Output BRAM File\n"); // write to file
      fprintf(out_file, "Test here:\n"); // write to file
      for(i=0;i<(sizeof(hwText)/sizeof(hwText[0])+1);i++)
      {
            fprintf(out_file, "%x\n", hwText[i]);
            printf("%d: %x\n", i, hwText[i]);
      }






return 0;
}

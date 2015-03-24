#include <stdio.h>
#define integer int

int main(void)
{
    int row=256;
    int col=256;
    int total_pixel=(row-2)*col;
    int pixel_int=total_pixel/72;
    if(total_pixel%72!=0)
        pixel_int++;
    printf("Total pixel_int is %d\n", pixel_int);
    int corn[pixel_int];
    int i;

    //Reset the hardware core.
    PIPELINE_mWriteSlaveReg0(XPAR_PIPELINE_0_BASEADDR, 0, 0x00000001);
   	PIPELINE_mWriteSlaveReg0(XPAR_PIPELINE_0_BASEADDR, 0, 0x00000000);

    //Send go signal to hardware
    PIPELINE_mWriteSlaveReg1(XPAR_PIPELINE_0_BASEADDR, 0,0x00000001);
    PIPELINE_mWriteSlaveReg1(XPAR_PIPELINE_0_BASEADDR, 0, 0x00000000);

    //wait for 'done' signal from the core
    done= PIPELINE_mReadSlaveReg2(XPAR_PIPELINE_0_BASEADDR, 0);
    while(done==0)
    {
        printf("the done is %d\n",done);
        done= PIPELINE_mReadSlaveReg2(XPAR_PIPELINE_0_BASEADDR, 0);
    }
    printf("the done is %d\n",done);

    //Read the output BRAM result.
    for(i=0;i<pixel_int;i++)
    {
        PIPELINE_mWriteSlaveReg6(XPAR_PIPELINE_0_BASEADDR,0,i);
        hwOutput[i] = PIPELINE_mWriteSlaveReg5(XPAR_PIPELINE_0_BASEADDR,0);
    }
    FILE *out_file = fopen("C:\\Users\\NecroStar\\Desktop\\SDKout\\test.txt", "w"); // write only

          // write to file vs write to screen
          fprintf(stdout, "this is a test %d\n", 2); // write to screen
          fprintf(out_file, "SDK to Matlab Output BRAM File\n"); // write to file
          for(i=0;i<sizeof(corn)/sizeof(corn[0]);i++)
          {
                fprintf(out_file, "%d\n", corn[i]);
          }

    return 0;
}

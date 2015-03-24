#include <stdio.h>

int spatial(int r1, int r2, int r3, int p1, int p2, int p3, int q1, int q2, int q3);
int spatial2(int r, int p, int q);
int spatial3(unsigned long long r[], unsigned long long p[], unsigned long long q[]);

int main(void)
{
    int result1, result2,result3;
    int r1 = 0x0A, r2=0x0A, r3=0x0A, p1=0x0A, p2=0x96, p3=0x0A, q1=0x0A, q2=0x0A, q3=0x0A;
    char again;
    /*
    int r = 0x0A0A0A;
    int p = 0x0A960A;
    int q = 0x0A0A0A;
    unsigned long long rr[2] = {0x0A000000000000000AL, 0x0000000000A0000A0AL};
    unsigned long long pp[2] = {0x0A0000000000000000L, 0x0000000000A5550A96L};
    unsigned long long qq[2] = {0x0A98764AA55AAAAA00LL, 0x0000000000A0000A0ALL};
    printf("R3 = %d\n", (rr[1]>>8)&0xFF);
    printf("R2 = %d\n", rr[1]&0xFF);
    printf("R1 = %d\n", (rr[0]>>64)&0xFF);
    printf("P3 = %d\n", (pp[1]>>8)&0xFF);
    printf("P2 = %d\n", (pp[1])&0xFF);
    printf("P1 = %d\n", (pp[0]>>64)&0xFF);
    printf("Q3 = %d\n", (qq[1]>>8)&0xFF);
    printf("Q2 = %d\n", (qq[1])&0xFF);
    printf("Q1 = %018x\n", qq[0]>>56);
    result1 = spatial(r1,r2,r3,p1,p2,p3,q1,q2,q3);
    result2 = spatial2(r,p,q);
    result3 = spatial3(rr,pp,qq);
    printf("Result1 is %d\n", result1);
    printf("Result2 is %d\n", result2);
    printf("Result3 is %d\n", result3);
    */
    do
    {
    printf("Enter r1 = ");
    scanf("%x", &r1);
    printf("Enter r2 = ");
    scanf("%x", &r2);
    printf("Enter r3 = ");
    scanf("%x", &r3);
    printf("Enter p1 = ");
    scanf("%x", &p1);
    printf("Enter p2 = ");
    scanf("%x", &p2);
    printf("Enter p3 = ");
    scanf("%x", &p3);
    printf("Enter q1 = ");
    scanf("%x", &q1);
    printf("Enter q2 = ");
    scanf("%x", &q2);
    printf("Enter q3 = ");
    scanf("%x", &q3);
    result1 = spatial(r1,r2,r3,p1,p2,p3,q1,q2,q3);
    printf("result is: %x\n", result1);
    printf("New entry (y/n): ");
    getchar();
    scanf("%c", &again);
    }
    while(again=='y');

    return 0;
}

int spatial(int r1, int r2, int r3, int p1, int p2, int p3, int q1, int q2, int q3)
{
    int result = ((r1*-1)+(r2*-1)+(r3*-1)+(p1*-1)+(p2*9)+(p3*-1)+(q1*-1)+(q2*-1)+(q3*-1))/9;
    if(result<0)
        result=0;
    return result;
}


int spatial2(int r, int p, int q)
{
    int r1,r2,r3,p1,p2,p3,q1,q2,q3,result;
    r1=(r>>16)&0xFF;
    r2=(r>>8)&0xFF;
    r3=r&0xFF;
    p1=(p>>16)&0xFF;
    p2=(p>>8)&0xFF;
    p3=p&0xFF;
    q1=(q>>16)&0xFF;
    q2=(q>>8)&0xFF;
    q3=q&0xFF;
    result = ((r1*-1)+(r2*-1)+(r3*-1)+(p1*-1)+(p2*9)+(p3*-1)+(q1*-1)+(q2*-1)+(q3*-1))/9;
    if(result<0)
        result=0;
    return result;
}

int spatial3(unsigned long long r[], unsigned long long p[], unsigned long long q[])
{
    int result9, result8, result7, result6, result5, result4, result3, result2, result1, result0;
    printf("R3 = %d\n", (r[1]>>8)&0xFF);
    printf("R2 = %d\n", r[1]&0xFF);
    printf("R1 = %d\n", (r[0]>>64)&0xFF);
    printf("P3 = %d\n", (p[1]>>8)&0xFF);
    printf("P2 = %d\n", (p[1])&0xFF);
    printf("P1 = %d\n", (p[0]>>64)&0xFF);
    printf("Q3 = %d\n", (q[1]>>8)&0xFF);
    printf("Q2 = %d\n", (q[1])&0xFF);
    printf("Q1 = %d\n", ((q[0]>>64)&0xFF));
    result9 = ((((r[1]>>8)&0xFF)*-1)+((r[1]&0xFF)*-1)+(((r[0]>>64)&0xFF)*-1)+(((p[1]>>8)&0xFF)*-1)+((p[1]&0xFF)*9)+(((p[0]>>64)&0xFF)*-1)+(((q[1]>>8)&0xFF)*-1)+((q[1]&0xFF)*-1)+(((q[0]>>64)&0xFF)*-1))/9;
    return result9;
}

/*****************************************************************************
* Filename:          C:\RCProjectDir\trunk\RCproject\RCproject.srcs\sources_1\edk\project_core/drivers/project_core_v1_00_a/src/project_core.h
* Version:           1.00.a
* Description:       project_core Driver Header File
* Date:              Mon Mar 16 16:46:58 2015 (by Create and Import Peripheral Wizard)
*****************************************************************************/

#ifndef PROJECT_CORE_H
#define PROJECT_CORE_H

/***************************** Include Files *******************************/

#include "xbasic_types.h"
#include "xstatus.h"
#include "xil_io.h"

/************************** Constant Definitions ***************************/


/**
 * User Logic Slave Space Offsets
 * -- SLV_REG0 : user logic slave module register 0
 * -- SLV_REG1 : user logic slave module register 1
 * -- SLV_REG2 : user logic slave module register 2
 * -- SLV_REG3 : user logic slave module register 3
 * -- SLV_REG4 : user logic slave module register 4
 * -- SLV_REG5 : user logic slave module register 5
 * -- SLV_REG6 : user logic slave module register 6
 * -- SLV_REG7 : user logic slave module register 7
 * -- SLV_REG8 : user logic slave module register 8
 * -- SLV_REG9 : user logic slave module register 9
 * -- SLV_REG10 : user logic slave module register 10
 * -- SLV_REG11 : user logic slave module register 11
 * -- SLV_REG12 : user logic slave module register 12
 * -- SLV_REG13 : user logic slave module register 13
 * -- SLV_REG14 : user logic slave module register 14
 * -- SLV_REG15 : user logic slave module register 15
 */
#define PROJECT_CORE_USER_SLV_SPACE_OFFSET (0x00000000)
#define PROJECT_CORE_SLV_REG0_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x00000000)
#define PROJECT_CORE_SLV_REG1_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x00000004)
#define PROJECT_CORE_SLV_REG2_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x00000008)
#define PROJECT_CORE_SLV_REG3_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x0000000C)
#define PROJECT_CORE_SLV_REG4_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x00000010)
#define PROJECT_CORE_SLV_REG5_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x00000014)
#define PROJECT_CORE_SLV_REG6_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x00000018)
#define PROJECT_CORE_SLV_REG7_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x0000001C)
#define PROJECT_CORE_SLV_REG8_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x00000020)
#define PROJECT_CORE_SLV_REG9_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x00000024)
#define PROJECT_CORE_SLV_REG10_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x00000028)
#define PROJECT_CORE_SLV_REG11_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x0000002C)
#define PROJECT_CORE_SLV_REG12_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x00000030)
#define PROJECT_CORE_SLV_REG13_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x00000034)
#define PROJECT_CORE_SLV_REG14_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x00000038)
#define PROJECT_CORE_SLV_REG15_OFFSET (PROJECT_CORE_USER_SLV_SPACE_OFFSET + 0x0000003C)

/**
 * Software Reset Space Register Offsets
 * -- RST : software reset register
 */
#define PROJECT_CORE_SOFT_RST_SPACE_OFFSET (0x00000100)
#define PROJECT_CORE_RST_REG_OFFSET (PROJECT_CORE_SOFT_RST_SPACE_OFFSET + 0x00000000)

/**
 * Software Reset Masks
 * -- SOFT_RESET : software reset
 */
#define SOFT_RESET (0x0000000A)

/**************************** Type Definitions *****************************/


/***************** Macros (Inline Functions) Definitions *******************/

/**
 *
 * Write a value to a PROJECT_CORE register. A 32 bit write is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is written.
 *
 * @param   BaseAddress is the base address of the PROJECT_CORE device.
 * @param   RegOffset is the register offset from the base to write to.
 * @param   Data is the data written to the register.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void PROJECT_CORE_mWriteReg(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Data)
 *
 */
#define PROJECT_CORE_mWriteReg(BaseAddress, RegOffset, Data) \
 	Xil_Out32((BaseAddress) + (RegOffset), (Xuint32)(Data))

/**
 *
 * Read a value from a PROJECT_CORE register. A 32 bit read is performed.
 * If the component is implemented in a smaller width, only the least
 * significant data is read from the register. The most significant data
 * will be read as 0.
 *
 * @param   BaseAddress is the base address of the PROJECT_CORE device.
 * @param   RegOffset is the register offset from the base to write to.
 *
 * @return  Data is the data from the register.
 *
 * @note
 * C-style signature:
 * 	Xuint32 PROJECT_CORE_mReadReg(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define PROJECT_CORE_mReadReg(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (RegOffset))


/**
 *
 * Write/Read 32 bit value to/from PROJECT_CORE user logic slave registers.
 *
 * @param   BaseAddress is the base address of the PROJECT_CORE device.
 * @param   RegOffset is the offset from the slave register to write to or read from.
 * @param   Value is the data written to the register.
 *
 * @return  Data is the data from the user logic slave register.
 *
 * @note
 * C-style signature:
 * 	void PROJECT_CORE_mWriteSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset, Xuint32 Value)
 * 	Xuint32 PROJECT_CORE_mReadSlaveRegn(Xuint32 BaseAddress, unsigned RegOffset)
 *
 */
#define PROJECT_CORE_mWriteSlaveReg0(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG0_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg1(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG1_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg2(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG2_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg3(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG3_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg4(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG4_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg5(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG5_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg6(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG6_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg7(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG7_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg8(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG8_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg9(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG9_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg10(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG10_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg11(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG11_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg12(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG12_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg13(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG13_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg14(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG14_OFFSET) + (RegOffset), (Xuint32)(Value))
#define PROJECT_CORE_mWriteSlaveReg15(BaseAddress, RegOffset, Value) \
 	Xil_Out32((BaseAddress) + (PROJECT_CORE_SLV_REG15_OFFSET) + (RegOffset), (Xuint32)(Value))

#define PROJECT_CORE_mReadSlaveReg0(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG0_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg1(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG1_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg2(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG2_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg3(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG3_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg4(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG4_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg5(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG5_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg6(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG6_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg7(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG7_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg8(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG8_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg9(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG9_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg10(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG10_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg11(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG11_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg12(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG12_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg13(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG13_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg14(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG14_OFFSET) + (RegOffset))
#define PROJECT_CORE_mReadSlaveReg15(BaseAddress, RegOffset) \
 	Xil_In32((BaseAddress) + (PROJECT_CORE_SLV_REG15_OFFSET) + (RegOffset))

/**
 *
 * Reset PROJECT_CORE via software.
 *
 * @param   BaseAddress is the base address of the PROJECT_CORE device.
 *
 * @return  None.
 *
 * @note
 * C-style signature:
 * 	void PROJECT_CORE_mReset(Xuint32 BaseAddress)
 *
 */
#define PROJECT_CORE_mReset(BaseAddress) \
 	Xil_Out32((BaseAddress)+(PROJECT_CORE_RST_REG_OFFSET), SOFT_RESET)

/************************** Function Prototypes ****************************/


/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the PROJECT_CORE instance to be worked on.
 *
 * @return
 *
 *    - XST_SUCCESS   if all self-test code passed
 *    - XST_FAILURE   if any self-test code failed
 *
 * @note    Caching must be turned off for this function to work.
 * @note    Self test may fail if data memory and device are not on the same bus.
 *
 */
XStatus PROJECT_CORE_SelfTest(void * baseaddr_p);
/**
*  Defines the number of registers available for read and write*/
#define TEST_AXI_LITE_USER_NUM_REG 16


#endif /** PROJECT_CORE_H */

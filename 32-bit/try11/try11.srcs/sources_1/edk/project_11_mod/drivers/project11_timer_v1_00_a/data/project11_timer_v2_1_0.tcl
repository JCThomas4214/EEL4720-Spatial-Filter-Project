##############################################################################
## Filename:          C:\try11\try11.srcs\sources_1\edk\project_11_mod/drivers/project11_timer_v1_00_a/data/project11_timer_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Wed Apr 22 13:02:18 2015 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "project11_timer" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}

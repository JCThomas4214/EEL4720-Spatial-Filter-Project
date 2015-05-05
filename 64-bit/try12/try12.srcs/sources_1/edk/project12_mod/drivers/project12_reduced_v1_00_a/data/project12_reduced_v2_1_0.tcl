##############################################################################
## Filename:          C:\try12\try12.srcs\sources_1\edk\project12_mod/drivers/project12_reduced_v1_00_a/data/project12_reduced_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Thu Apr 23 13:30:55 2015 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "project12_reduced" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}

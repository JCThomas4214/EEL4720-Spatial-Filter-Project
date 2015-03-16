##############################################################################
## Filename:          C:\RCProjectDir\trunk\RCproject\RCproject.srcs\sources_1\edk\project_core/drivers/project_core_v1_00_a/data/project_core_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Mon Mar 16 16:46:58 2015 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "project_core" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}

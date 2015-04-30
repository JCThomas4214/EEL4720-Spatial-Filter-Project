##############################################################################
## Filename:          C:\try11\try11.srcs\sources_1\edk\project_11_mod/drivers/project11_reduced_v1_00_a/data/project11_reduced_v2_1_0.tcl
## Description:       Microprocess Driver Command (tcl)
## Date:              Tue Apr 21 18:04:57 2015 (by Create and Import Peripheral Wizard)
##############################################################################

#uses "xillib.tcl"

proc generate {drv_handle} {
  xdefine_include_file $drv_handle "xparameters.h" "project11_reduced" "NUM_INSTANCES" "DEVICE_ID" "C_BASEADDR" "C_HIGHADDR" 
}

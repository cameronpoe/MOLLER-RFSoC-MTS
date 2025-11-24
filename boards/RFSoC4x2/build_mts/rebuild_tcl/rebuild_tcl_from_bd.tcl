set origin_dir ".."
set _xil_proj_name_ "mts"
set proj_loc "${origin_dir}/${_xil_proj_name_}/${_xil_proj_name_}.xpr"
set bd_loc "${origin_dir}/${_xil_proj_name_}/${_xil_proj_name_}.srcs/sources_1/bd/${_xil_proj_name_}/${_xil_proj_name_}.bd"
set output_name "tmp_tcl_from_bd"

# Opens project
open_project $proj_loc

# Opens block diagram file
open_bd_design $bd_loc

# Reverse-engineers TCL script to create block diagram, and sends to $output_name
write_bd_tcl -force $output_name




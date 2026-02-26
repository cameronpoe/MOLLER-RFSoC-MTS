set origin_dir ".."  

open_project mts.xpr
write_ip_tcl -force [get_ips fir_compiler_0] ${origin_dir}/mts_MOLLER_fir_compiler_0.tcl
write_project_tcl -force ${origin_dir}/mts_MOLLER.tcl
close_project

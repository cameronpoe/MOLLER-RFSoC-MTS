#!/usr/bin/tclsh

set origin_dir "."
set _xil_proj_name_ "mts"
set proj_loc "${origin_dir}/${_xil_proj_name_}/${_xil_proj_name_}.xpr"
set bd_loc "${origin_dir}/${_xil_proj_name_}/${_xil_proj_name_}.srcs/sources_1/bd/${_xil_proj_name_}/${_xil_proj_name_}.bd"
set input_name "tmp_tcl_from_bd"


set first_start_line ".*set bCheckIPsPassed 1.*"
set first_end_line ".*Procedure to create entire design; Provide argument to make.*"

# set second_start_line ".*if \{ \$parentCell eq \"\" \} \{.*"
# set second_start_line ".*if { \$parentCell eq \"\" } {.*"
set second_start_line {\{ \$parentCell eq "" \} \{}
set second_end_line ".*save_bd_design.*"

set fileHandle [open "${origin_dir}/${input_name}.tcl" "r"]
set header_handle [open "${origin_dir}/header.tcl" "r"]
set footer_handle [open "${origin_dir}/footer.tcl" "r"]
set output_handle [open "${origin_dir}/${_xil_proj_name_}-MOLLER.tcl" "w"]


set header_data [read $header_handle]
set footer_data [read $footer_handle]

puts -nonewline $output_handle $header_data

set lineNum 0

set first_write_bit 0
set second_write_bit 0

while {[gets $fileHandle line] >= 0} {
    incr lineNum

    if {[regexp $first_start_line $line]} {
        set first_write_bit 1
        puts $output_handle "\n"
    } elseif {[regexp $first_end_line $line]} {
        set first_write_bit 0
    }
    if {$first_write_bit} {
        puts -nonewline $output_handle "\n  ${line}"
    }
    
    if {[regexp $second_start_line $line]} {
        set second_write_bit 1
        puts $output_handle "\n  variable script_folder"
    } 
    if {$second_write_bit} {
        puts -nonewline $output_handle "\n${line}"
    }
    if {[regexp $second_end_line $line]} {
        set second_write_bit 0
        puts $output_handle "\n"
    }

}

puts -nonewline $output_handle $footer_data

close $fileHandle
close $header_handle
close $footer_handle
close $output_handle

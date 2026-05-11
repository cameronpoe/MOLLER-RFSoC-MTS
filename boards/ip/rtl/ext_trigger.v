`timescale 1ns / 1ps


module ext_trigger(
    input aclk,
    input aresetn,
    
    input trigger,
    
    input [63:0] ts_in,
    
    input s_tlast,
    
    output reg [63:0] m_axis_tdata,
    output reg m_axis_tvalid,
    output reg m_axis_tlast
    );
    
    
    
endmodule

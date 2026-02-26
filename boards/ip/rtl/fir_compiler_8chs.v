`timescale 1ns / 1ps

module fir_compiler_8chs(

    input aclk,
    input aresetn,

    input [15:0] s00_axis_tdata,
    input s00_axis_tvalid,
    output s00_axis_tready,
    input [15:0] s01_axis_tdata,
    input s01_axis_tvalid,
    output s01_axis_tready,
    input [15:0] s02_axis_tdata,
    input s02_axis_tvalid,
    output s02_axis_tready,
    input [15:0] s03_axis_tdata,
    input s03_axis_tvalid,
    output s03_axis_tready,
    input [15:0] s04_axis_tdata,
    input s04_axis_tvalid,
    output s04_axis_tready,
    input [15:0] s05_axis_tdata,
    input s05_axis_tvalid,
    output s05_axis_tready,
    input [15:0] s06_axis_tdata,
    input s06_axis_tvalid,
    output s06_axis_tready,
    input [15:0] s07_axis_tdata,
    input s07_axis_tvalid,
    output s07_axis_tready,
    
    output [23:0] m00_axis_tdata,
    output m00_axis_tvalid,
    output [23:0] m01_axis_tdata,
    output m01_axis_tvalid,
    output [23:0] m02_axis_tdata,
    output m02_axis_tvalid,
    output [23:0] m03_axis_tdata,
    output m03_axis_tvalid,
    output [23:0] m04_axis_tdata,
    output m04_axis_tvalid,
    output[23:0]  m05_axis_tdata,
    output m05_axis_tvalid,
    output[23:0]  m06_axis_tdata,
    output m06_axis_tvalid,
    output [23:0] m07_axis_tdata,
    output m07_axis_tvalid
    );
    
    fir_compiler_0 fir00 (
        .aresetn(aresetn),
        .aclk(aclk),
        .s_axis_data_tvalid(s00_axis_tvalid),
        .s_axis_data_tready(s00_axis_tready),
        .s_axis_data_tdata(s00_axis_tdata),
        .m_axis_data_tvalid(m00_axis_tvalid),
        .m_axis_data_tdata(m00_axis_tdata) 
    );
    
    fir_compiler_0 fir01 (
        .aresetn(aresetn),
        .aclk(aclk),
        .s_axis_data_tvalid(s01_axis_tvalid),
        .s_axis_data_tready(s01_axis_tready),
        .s_axis_data_tdata(s01_axis_tdata),
        .m_axis_data_tvalid(m01_axis_tvalid),
        .m_axis_data_tdata(m01_axis_tdata) 
    );
    
    fir_compiler_0 fir02 (
        .aresetn(aresetn),
        .aclk(aclk),
        .s_axis_data_tvalid(s02_axis_tvalid),
        .s_axis_data_tready(s02_axis_tready),
        .s_axis_data_tdata(s02_axis_tdata),
        .m_axis_data_tvalid(m02_axis_tvalid),
        .m_axis_data_tdata(m02_axis_tdata) 
    );
    
    fir_compiler_0 fir03 (
        .aresetn(aresetn),
        .aclk(aclk),
        .s_axis_data_tvalid(s03_axis_tvalid),
        .s_axis_data_tready(s03_axis_tready),
        .s_axis_data_tdata(s03_axis_tdata),
        .m_axis_data_tvalid(m03_axis_tvalid),
        .m_axis_data_tdata(m03_axis_tdata) 
    );
    
    fir_compiler_0 fir04 (
        .aresetn(aresetn),
        .aclk(aclk),
        .s_axis_data_tvalid(s04_axis_tvalid),
        .s_axis_data_tready(s04_axis_tready),
        .s_axis_data_tdata(s04_axis_tdata),
        .m_axis_data_tvalid(m04_axis_tvalid),
        .m_axis_data_tdata(m04_axis_tdata) 
    );
    
    fir_compiler_0 fir05 (
        .aresetn(aresetn),
        .aclk(aclk),
        .s_axis_data_tvalid(s05_axis_tvalid),
        .s_axis_data_tready(s05_axis_tready),
        .s_axis_data_tdata(s05_axis_tdata),
        .m_axis_data_tvalid(m05_axis_tvalid),
        .m_axis_data_tdata(m05_axis_tdata) 
    );
    
    fir_compiler_0 fir06 (
        .aresetn(aresetn),
        .aclk(aclk),
        .s_axis_data_tvalid(s06_axis_tvalid),
        .s_axis_data_tready(s06_axis_tready),
        .s_axis_data_tdata(s06_axis_tdata),
        .m_axis_data_tvalid(m06_axis_tvalid),
        .m_axis_data_tdata(m06_axis_tdata) 
    );
    
    fir_compiler_0 fir07 (
        .aresetn(aresetn),
        .aclk(aclk),
        .s_axis_data_tvalid(s07_axis_tvalid),
        .s_axis_data_tready(s07_axis_tready),
        .s_axis_data_tdata(s07_axis_tdata),
        .m_axis_data_tvalid(m07_axis_tvalid),
        .m_axis_data_tdata(m07_axis_tdata) 
    );
    
    
endmodule
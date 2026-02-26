`timescale 1ns / 1ps

module tvalid_emit(

    input aclk,
    input aresetn,
    
    output reg tvalid = 1'b0
    
    );
    
    always @(posedge aclk) begin
        if (aresetn == 1'b0) begin
            tvalid <= 1'b0;
        end else begin
            tvalid <= 1'b1;
        end
    end

endmodule

module fir_compiler_8chs_tb;

    reg aclk = 1'b1;
    reg aresetn = 1'b1;
    
    always begin
        #4 aclk <= ~aclk;
    end
    
    reg [15:0] tdata = 16'h0000;
    wire tvalid;
    
    wire s00_axis_tready;
    wire s01_axis_tready;
    wire s02_axis_tready;
    wire s03_axis_tready;
    wire s04_axis_tready;
    wire s05_axis_tready;
    wire s06_axis_tready;
    wire s07_axis_tready;
    
    wire [23:0] m00_axis_tdata;
    wire m00_axis_tvalid;
    wire [23:0] m01_axis_tdata;
    wire m01_axis_tvalid;
    wire [23:0] m02_axis_tdata;
    wire m02_axis_tvalid;
    wire [23:0] m03_axis_tdata;
    wire m03_axis_tvalid;
    wire [23:0] m04_axis_tdata;
    wire m04_axis_tvalid;
    wire [23:0] m05_axis_tdata;
    wire m05_axis_tvalid;
    wire [23:0] m06_axis_tdata;
    wire m06_axis_tvalid;
    wire [23:0] m07_axis_tdata;
    wire m07_axis_tvalid;
    
    tvalid_emit mytvalid (
        .aclk(aclk),
        .aresetn(aresetn),
        .tvalid(tvalid)
    );
    
    fir_compiler_8chs dut (
        .aclk(aclk),
        .aresetn(aresetn),
        
        .s00_axis_tdata(tdata),
        .s00_axis_tvalid(tvalid),
        .s00_axis_tready(s00_axis_tready),
        .s01_axis_tdata(tdata),
        .s01_axis_tvalid(tvalid),
        .s01_axis_tready(s01_axis_tready),
        .s02_axis_tdata(tdata),
        .s02_axis_tvalid(tvalid),
        .s02_axis_tready(s02_axis_tready),
        .s03_axis_tdata(tdata),
        .s03_axis_tvalid(tvalid),
        .s03_axis_tready(s03_axis_tready),
        .s04_axis_tdata(tdata),
        .s04_axis_tvalid(tvalid),
        .s04_axis_tready(s04_axis_tready),
        .s05_axis_tdata(tdata),
        .s05_axis_tvalid(tvalid),
        .s05_axis_tready(s05_axis_tready),
        .s06_axis_tdata(tdata),
        .s06_axis_tvalid(tvalid),
        .s06_axis_tready(s06_axis_tready),
        .s07_axis_tdata(tdata),
        .s07_axis_tvalid(tvalid),
        .s07_axis_tready(s07_axis_tready),
        
        .m00_axis_tdata(m00_axis_tdata),
        .m00_axis_tvalid(m00_axis_tvalid),
        .m01_axis_tdata(m01_axis_tdata),
        .m01_axis_tvalid(m01_axis_tvalid),
        .m02_axis_tdata(m02_axis_tdata),
        .m02_axis_tvalid(m02_axis_tvalid),
        .m03_axis_tdata(m03_axis_tdata),
        .m03_axis_tvalid(m03_axis_tvalid),
        .m04_axis_tdata(m04_axis_tdata),
        .m04_axis_tvalid(m04_axis_tvalid),
        .m05_axis_tdata(m05_axis_tdata),
        .m05_axis_tvalid(m05_axis_tvalid),
        .m06_axis_tdata(m06_axis_tdata),
        .m06_axis_tvalid(m06_axis_tvalid),
        .m07_axis_tdata(m07_axis_tdata),
        .m07_axis_tvalid(m07_axis_tvalid)
    );
        
    initial begin
    
        repeat (8)
            @(posedge aclk);
            
        aresetn <= 1'b0;
        
        repeat(64)
            @(posedge aclk);
        
        aresetn <= 1'b1;
        
        repeat (128)
            @(posedge aclk);
        
        tdata <= 16'b0111111111111111;
        
        @(posedge aclk);
        
        tdata <= 16'h0000;
        
        repeat(256)
            @(posedge aclk);
            
            
        
    end
    
endmodule

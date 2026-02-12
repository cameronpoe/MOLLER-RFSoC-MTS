`timescale 1ns / 1ps


// Assumes all slave AXI streams have tvalid go high once every 8 aclk cycles, and all tvalids go high on same beat.
module adc_mux # (parameter NUM_STREAMS=8, IN_DATA_WIDTH=24, OUT_DATA_WIDTH=64) (

    input aclk,
    input aresetn,

    // AXI stream slave port 0
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_0 TDATA"  *) input [IN_DATA_WIDTH-1:0] s_axis_0_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_0 TVALID" *) input s_axis_0_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_0 TREADY" *) output reg s_axis_0_tready = 1'b1,
    
    // AXI stream slave port 1
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_1 TDATA"  *) input [IN_DATA_WIDTH-1:0] s_axis_1_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_1 TVALID" *) input s_axis_1_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_1 TREADY" *) output reg s_axis_1_tready = 1'b1,
    
    // AXI stream slave port 2
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_2 TDATA"  *) input [IN_DATA_WIDTH-1:0] s_axis_2_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_2 TVALID" *) input s_axis_2_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_2 TREADY" *) output reg s_axis_2_tready = 1'b1,
    
    // AXI stream slave port 3
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_3 TDATA"  *) input [IN_DATA_WIDTH-1:0] s_axis_3_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_3 TVALID" *) input s_axis_3_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_3 TREADY" *) output reg s_axis_3_tready = 1'b1,
    
    // AXI stream slave port 4
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_4 TDATA"  *) input [IN_DATA_WIDTH-1:0] s_axis_4_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_4 TVALID" *) input s_axis_4_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_4 TREADY" *) output reg s_axis_4_tready = 1'b1,
    
    // AXI stream slave port 5
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_5 TDATA"  *) input [IN_DATA_WIDTH-1:0] s_axis_5_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_5 TVALID" *) input s_axis_5_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_5 TREADY" *) output reg s_axis_5_tready = 1'b1,
    
    // AXI stream slave port 6
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_6 TDATA"  *) input [IN_DATA_WIDTH-1:0] s_axis_6_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_6 TVALID" *) input s_axis_6_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_6 TREADY" *) output reg s_axis_6_tready = 1'b1,
    
    // AXI stream slave port 7
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_7 TDATA"  *) input [IN_DATA_WIDTH-1:0] s_axis_7_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_7 TVALID" *) input s_axis_7_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_7 TREADY" *) output reg s_axis_7_tready = 1'b1,
    
    // AXI stream master port
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TDATA"  *) output reg [OUT_DATA_WIDTH-1:0] m_axis_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TVALID" *) output reg m_axis_tvalid = 1'b0,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TREADY" *) input m_axis_tready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TUSER" *) output reg m_axis_tuser = 1'b0

    );
    
//    reg [NUM_STREAMS*IN_DATA_WIDTH-1:0] all_streams;
    wire all_valid;
//    reg counting_valid = 1'b0;
    assign all_valid = s_axis_0_tvalid & s_axis_1_tvalid & s_axis_2_tvalid & s_axis_3_tvalid & s_axis_4_tvalid & s_axis_5_tvalid & s_axis_6_tvalid & s_axis_7_tvalid;
    reg [2:0] num_cycles = 3'd0;
    
    always @(posedge aclk) begin
//        all_streams <= {s_axis_0_tdata, s_axis_1_tdata, s_axis_2_tdata, s_axis_3_tdata, s_axis_4_tdata, s_axis_5_tdata, s_axis_6_tdata, s_axis_7_tdata};
        if (aresetn == 1'b0) begin
            num_cycles <= 3'd0;
            s_axis_0_tready <= 1'b0;
            s_axis_1_tready <= 1'b0;
            s_axis_2_tready <= 1'b0;
            s_axis_3_tready <= 1'b0;
            s_axis_4_tready <= 1'b0;
            s_axis_5_tready <= 1'b0;
            s_axis_6_tready <= 1'b0;
            s_axis_7_tready <= 1'b0;
            m_axis_tvalid   <= 1'b0;
            m_axis_tuser    <= 1'b0;
        end else begin 
            if (all_valid == 1'b1) begin
                num_cycles <= 3'd1;
                m_axis_tvalid <= 1'b1;
                m_axis_tdata <= {s_axis_0_tdata, s_axis_1_tdata, s_axis_2_tdata[23:8]};
                m_axis_tuser <= 1'b1;
                s_axis_0_tready <= 1'b0;
                s_axis_1_tready <= 1'b0;
                s_axis_2_tready <= 1'b0;
                s_axis_3_tready <= 1'b0;
                s_axis_4_tready <= 1'b0;
                s_axis_5_tready <= 1'b0;
                s_axis_6_tready <= 1'b0;
                s_axis_7_tready <= 1'b0;
//                counting_valid <= 1'b1;
            end else if (num_cycles != 3'd0) begin
                if (num_cycles == 3'd2) begin
                    m_axis_tvalid <= 1'b1;
                    m_axis_tdata <= {s_axis_2_tdata[7:0], s_axis_3_tdata, s_axis_4_tdata, s_axis_5_tdata[23:16]};
                end else if (num_cycles == 3'd4) begin
                    m_axis_tvalid <= 1'b1;
                    m_axis_tdata <= {s_axis_5_tdata[15:0], s_axis_6_tdata, s_axis_7_tdata};
                end else begin
                    m_axis_tvalid <= 1'b0;
                end
                
                if (num_cycles == 3'd5) begin
                    s_axis_0_tready <= 1'b1;
                    s_axis_1_tready <= 1'b1;
                    s_axis_2_tready <= 1'b1;
                    s_axis_3_tready <= 1'b1;
                    s_axis_4_tready <= 1'b1;
                    s_axis_5_tready <= 1'b1;
                    s_axis_6_tready <= 1'b1;
                    s_axis_7_tready <= 1'b1;
                end
                
                m_axis_tuser <= 1'b0;
                num_cycles <= num_cycles + 3'd1;
            end
            
        end
        
    end    
    
endmodule

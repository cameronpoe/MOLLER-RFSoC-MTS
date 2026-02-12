`timescale 1ns / 1ps

module add_tlast(
    input aclk,
    input aresetn,
    
    input [31:0] words_per_packet,
    
    input [63:0] s_axis_tdata,
    input s_axis_tvalid,
    output reg s_axis_tready,
    input s_axis_tuser,
    
    output reg [63:0] m_axis_tdata,
    output reg m_axis_tvalid, 
    output reg m_axis_tlast, 
    output [1:0] m_axis_tkeep, 
    input m_axis_tready
    );
    
    assign m_axis_tkeep = 2'b11;
    
    // Counts the number of valid words in a packet
    reg [31:0] count = 32'd0;
    reg seen_tuser = 1'b0;
    wire streaming_enable;
    assign streaming_enable = seen_tuser | s_axis_tuser;
    
    always @(posedge aclk) begin
        if (aresetn == 1'b0 | m_axis_tready == 1'b0) begin
            m_axis_tvalid <= 1'b0;
            m_axis_tlast <= 1'b0;
            s_axis_tready <= 1'b0;
            count <= 32'b0;
            seen_tuser <= 1'b0;
        end else begin
            s_axis_tready <= 1'b1;
            
            if (s_axis_tuser == 1'b1) begin
                seen_tuser <= 1'b1;
            end
            
            if (streaming_enable) begin
                // If receives a valid word, increments count
                if (s_axis_tvalid == 1'b1) begin
                    if (count == words_per_packet - 32'd1) begin
                        count <= 32'd0;
                        m_axis_tdata <= s_axis_tdata;
                        m_axis_tvalid <= 1'b1;
                        m_axis_tlast <= 1'b1;
                    end else begin
                        count <= count + 32'd1;
                        m_axis_tdata <= s_axis_tdata;
                        m_axis_tvalid <= 1'b1;
                    end
                end else begin
                    m_axis_tvalid <= 1'b0;
                    m_axis_tlast <= 1'b0;
                end
            end
        end
    end
endmodule

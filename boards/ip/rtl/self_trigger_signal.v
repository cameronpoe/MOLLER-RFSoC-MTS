`timescale 1ns / 1ps

module self_trigger_signal #(
    parameter real TRIGGER_FREQ = 1920.0,
    parameter real DUTY_CYCLE_FRACTION = 0.9616,
    parameter real ACLK_FREQ = 125_000_000.0
)(
    
    input aclk,
    input aresetn,
    
    output reg trigger_signal = 1'b0
    
    );
    
    // Computes number of clock cycles from frequencies. Also, assigning real to integer ROUNDS instead of floors
    localparam integer ACLK_CYCLES_FULL = ACLK_FREQ/TRIGGER_FREQ;
    localparam integer ACLK_CYCLES_STABLE = ACLK_FREQ/TRIGGER_FREQ*DUTY_CYCLE_FRACTION ;
    
    reg [63:0] counter = 64'd0;
    
    always @(posedge aclk) begin
        if (aresetn == 1'b0) begin
            trigger_signal <= 1'b0;
            counter <= 64'd0;
        end else begin
            if (counter < ACLK_CYCLES_STABLE-1) begin
                trigger_signal <= 1'b1;
            end else if ((counter >= ACLK_CYCLES_STABLE) & (counter < ACLK_CYCLES_FULL-1)) begin
                trigger_signal <= 1'b0;
            end
            
            if (counter < ACLK_CYCLES_FULL-1)
                counter <= counter + 64'd1;
            else
                counter <= 64'd0;
        end
    end
    
endmodule
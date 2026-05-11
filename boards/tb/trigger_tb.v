`timescale 1ns / 1ps

module trigger_tb;
    
    reg aclk = 1'b1;    
    always
        #4 aclk = ~aclk;
        
    reg aresetn = 1'b1;
    
    wire trigger_signal;
    
    reg [31:0] num_triggers = 32'd12;
    wire [63:0] m_axis_tdata;
    wire m_axis_tvalid;
    wire m_axis_tlast;
    
    wire [62:0] ts;
    
    self_trigger_signal #(.TRIGGER_FREQ(15_625_000), .DUTY_CYCLE_FRACTION(0.625)) self_trigger_signal_dut (
        .aclk(aclk),
        .aresetn(aresetn),
        .trigger_signal(trigger_signal)
    );
    
    trigger_timestamp trigger_timestamp_dut (
        .aclk(aclk),
        .aresetn(aresetn),
        .trigger(trigger_signal),
        .ts(ts),
        .num_triggers(num_triggers),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tlast(m_axis_tlast)
    );
    
    subsystem_timestamp #(.WIDTH(63)) subsystem_timestamp_dut (
        .aclk(aclk),
        .aresetn(aresetn),
        .load(1'b0),
        .load_ts(63'd0),
        .ts(ts)
    );
    
    initial begin
        repeat(50)
            @(posedge aclk);
        
        aresetn <= 1'b0;
        
        repeat(32)
            @(posedge aclk);
        
        aresetn <= 1'b1;
        
        repeat(500)
            @(posedge aclk);
    end

endmodule

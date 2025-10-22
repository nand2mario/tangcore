//
// Blinky | From NESTang top level
// nand2mario
// @fjpolo
//

// `timescale 1ns/100ps

module top(
    input sys_clk,
    input s0,
    input s1,
    input s2,

    // LEDs
    output [7:0] led    // PMOD1
);
localparam WIDTH = 27;
localparam COUNT_MAX = 120_000_000 - 1;

reg [WIDTH-1:0] counter = 'h0;
reg             led_reg = 1'b0;

always @(posedge sys_clk) begin
    if (counter == COUNT_MAX) begin
        // 1. Counter reached the limit (1 second)
        counter <= 0;
    end else begin
        // 3. Increment the counter
        counter <= counter + 1;
    end
end

always @(posedge sys_clk) begin
    if (counter == COUNT_MAX) begin
        // 2. Toggle the LED output
        led_reg <= ~led_reg;
    end
end

assign led[0] = led_reg;
assign led[1] = 1'b1;
assign led[2] = 1'b0;
assign led[3] = 1'b1;
assign led[4] = 1'b0;
assign led[5] = 1'b1;
assign led[6] = 1'b0;
assign led[7] = 1'b1;


endmodule
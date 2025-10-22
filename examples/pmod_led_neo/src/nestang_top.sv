/*
 * SPDX-FileCopyrightText: 2018-2024 Shenzhen Sipeed Technology CO,LTD.
 *
 * SPDX-License-Identifier: Apache-2.0
 */
//
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
    reg [24:0] time_cnt;    
    reg [7:0] led_reg;
    reg led_dir = 1'b1;
    reg running;            // Indicates the status of the running LEDs
    reg [23:0] flash_cnt;   // Counter for controlling LED flashing status
    reg flash_state;        // Used to indicate LED flashing status

    always @(posedge sys_clk) begin
        if (!s1) begin
            led_reg <= {8{1'b1}}; // Press s1 then all LEDs are always on
        end 
        else if (!s2) begin
            if (flash_cnt < 24'd5000000) begin
                flash_cnt <= flash_cnt + 24'b1;
            end 
            else begin
                flash_cnt <= 24'd0;
                flash_state <= ~flash_state; // Switch LEDs flashing state
            end
            led_reg <= flash_state ? {8{1'b1}} : {8{1'b0}};// Press s2 then all LEDs flash
        end 
        else if (s2 && s1) begin
            if (time_cnt < 24'd10000000) begin
                time_cnt <= time_cnt + 24'b1;
            end 
            else begin
                time_cnt <= 24'd0;
                if (led_dir) begin
                    if (led_reg == {8{1'b1}}) begin
                        led_dir <= 0; // All LEDs light turned on and then reverse
                    end 
                    else begin
                        led_reg <= (led_reg << 1) | 8'b1; // LEDs turn up in sequence
                    end
                end 
                else begin
                    if (led_reg == {8{1'b0}}) begin
                        led_dir <= 1; // Switch to forward direction after all LEDs turn off
                    end 
                    else begin
                        led_reg <= led_reg >> 1; // Turn LEDs off in sequence
                    end
                end
            end
        end 
    end

    assign led[7:0] = ~led_reg[7:0];  //All LEDs are connected to the common anode 
                                      //All LEDs will light up when the IO logic is low. 


endmodule
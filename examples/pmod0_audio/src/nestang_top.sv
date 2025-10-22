//
// @fjpolo
//

// `timescale 1ns/100ps

module top(
    input  logic sys_clk,   // 120 MHz
    input  logic s0,        // Unused
    input  logic s1,        // Unused
    input  logic s2,        // Unused
    //PMOD0
    output logic [7:0] o_pmod0,  // PMOD0
    // PMOD1
    output logic [7:0] o_pmod1   // PMOD1
);

    // Parameters for the NCO module
    parameter LGTBL = 9;   // Log, base two, of the table size (P in nco.v)
    parameter W = 32;      // Word-size (width of phase accumulator and frequency word)
    parameter OW = 8;      // Output width (width of the sine wave sample)

    reg             i_ld;
    reg  [W-1:0]    i_dphase;
    reg             i_ce = 1'b1;
    wire [OW-1:0]   o_val;

    initial i_ld = 1'b1;                // Load enabled
    initial i_dphase = 32'd42949673;

    // Instantiate the NCO module
    nco #(
        .LGTBL(LGTBL),
        .W(W),
        .OW(OW)
    ) u_nco (
        .i_clk(sys_clk),
        .i_ld(i_ld),
        .i_dphase(i_dphase),
        .i_ce(i_ce),
        .o_val(o_val)
    );

    assign o_pmod0[0] = o_val;
    assign o_pmod0[1] = o_val;

endmodule
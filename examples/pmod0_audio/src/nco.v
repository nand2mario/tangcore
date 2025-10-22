// =============================================================================
// File        : nco.v
// Author      : @fjpolo
// email       : fjpolo@gmail.com
// Description : <Brief description of the module or file>
// License     : MIT License
//
// Copyright (c) 2025 | @fjpolo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
// =============================================================================

// `default_nettype none
`timescale 1ps/1ps

module	nco(i_clk, i_reset, i_ld, i_dphase, i_ce, o_val);
	parameter	LGTBL = 9,  // Log, base two, of the table size
			    W = 32,     // Word-size
			    OW = 8;     // Output width
	localparam	P = LGTBL;
	//
	input	wire		        i_clk;
	input	wire		        i_reset;
	//
	input	wire		        i_ld;
	input	wire	[W-1:0]	    i_dphase;
	//
	input	wire		        i_ce;
	output	wire    [OW-1:0]	o_val;

    reg	[W-1:0]	r_step;

	initial	r_step = 0;
	always @(posedge i_clk)
        if (i_ld)
            r_step <= i_dphase; // = 2^W * f/fs

    reg	[W-1:0]	r_phase;

	initial	r_phase = 0;
	always @(posedge i_clk)
	if (i_ce)
		// PHI[n] = PHI[n-1] + 2^W * f / fs
		r_phase <= r_phase + r_step;
    	
        // SIN LUT
        /* verilator lint_off UNUSEDSIGNAL */
        wire nco_o_aux;
        /* verilator lint_on UNUSEDSIGNAL */
        sintable #(.PW(P), .OW(OW))
		stbl(
            .i_clk(i_clk), 
            .i_reset(i_reset), 
            .i_ce(i_ce), 
            .i_phase(r_phase[(W-1):(W-P)]), 
            .o_val(o_val),
            .i_aux(1'b0), 
            .o_aux(nco_o_aux)
            );
endmodule

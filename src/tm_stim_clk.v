//******************************************************************************
//  file:     tm_stim_clk.v
//
//  author:   JAY CONVERTINO
//
//  date:     2022/10/24
//
//  about:    Brief
//  clock simulator creates multiple clocks and resets for testing.
//
//  license: License MIT
//  Copyright 2022 Jay Convertino
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//******************************************************************************

`timescale 1 ns/10 ps

/*
 * Module: clk_stimulus
 *
 * clock simulator creates multiple clocks and resets for testing.
 *
 * Parameters:
 *
 * CLOCKS         - Number of clocks
 * CLOCK_BASE     - Clock time base mhz
 * CLOCK_INC      - Time diff for other clocks, only used for async mode
 * CLOCK_ASYNC    - Used time diff to generate async clocks (1), 0 is sync clock
 * RESETS         - Number of resets
 * RESET_BASE     - Time to stay in reset
 * RESET_INC      - Time diff for other resets
 *
 * Ports:
 *
 * clkv    - clock output vector
 * rstnv   - negative reset output vector
 * rstv    - positive reset output vector
 */
module clk_stimulus #(
    parameter CLOCKS = 2,
    parameter CLOCK_BASE = 1000000,
    parameter CLOCK_INC = 100,
    parameter CLOCK_ASYNC = 0,
    parameter RESETS = 2,
    parameter RESET_BASE = 200,
    parameter RESET_INC = 100
  )
  (
    output reg [CLOCKS-1:0] clkv,
    output reg [RESETS-1:0] rstnv,
    output reg [RESETS-1:0] rstv
  );
  
  /// scale clock base to a clock period in MHz. Good up to 1 GHz.
  localparam lp_PERIOD = 1000000000/CLOCK_BASE;
  
  /// index for clock generation
  genvar clk_index;
  /// index for reset generation
  genvar rst_index;
  
  //****************************************************************************
  /// @brief generator for clock vector
  //****************************************************************************
  generate
    // loop till all clocks created
    for (clk_index = 0; clk_index < CLOCKS; clk_index = clk_index + 1) begin
      // iverilog 
      initial begin
        clkv = 0;
      end
      
      always begin
        // toggle indexed clock
        clkv[clk_index] <= ~clkv[clk_index];
        
        if(CLOCK_ASYNC != 0) begin
          // wait for a certian amount of time, increase based on index * increment
          #((lp_PERIOD+(CLOCK_INC*clk_index))/2);
        end else begin
          // wait for a certian amount of time, these are multples of the clock to keep them in sync
          #((lp_PERIOD*( clk_index ? clk_index * 2 : 1))/2);
        end
      end
    end
  endgenerate
  
  //****************************************************************************
  /// @brief generator for reset vector
  //****************************************************************************
  generate
    // loop till all resets created
    for (rst_index = 0; rst_index < RESETS; rst_index = rst_index + 1) begin
      initial begin
        // start off with resets in reset state.
        rstnv[rst_index] <= 1'b0;
        
        rstv[rst_index] <= 1'b1;
        
        // wait for a certain amount of time, increase based on index * increment
        #(RESET_BASE-(RESET_INC*rst_index))
        
        // no longer in reset
        rstnv[rst_index] <= 1'b1;
        
        rstv[rst_index] <= 1'b0;
      end
    end
  endgenerate
endmodule


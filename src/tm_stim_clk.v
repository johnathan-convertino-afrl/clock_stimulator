//******************************************************************************
/// @file    tm_stim_clk.v
/// @author  JAY CONVERTINO
/// @date    2022.12.05
/// @brief   Generic AXIS clock test bench module
///
/// @LICENSE MIT
///  Copyright 2022 Jay Convertino
///
///  Permission is hereby granted, free of charge, to any person obtaining a copy
///  of this software and associated documentation files (the "Software"), to 
///  deal in the Software without restriction, including without limitation the
///  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or 
///  sell copies of the Software, and to permit persons to whom the Software is 
///  furnished to do so, subject to the following conditions:
///
///  The above copyright notice and this permission notice shall be included in 
///  all copies or substantial portions of the Software.
///
///  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
///  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
///  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
///  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
///  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
///  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
///  IN THE SOFTWARE.
//******************************************************************************

`timescale 1 ns/10 ps

//******************************************************************************
/// @brief clock simulator creates multiple clocks and resets for testing.
//******************************************************************************
module clk_stimulus #(
    parameter CLOCKS = 2,           /**< # of clocks */
    parameter CLOCK_BASE = 1000000, /**< clock time base mhz */
    parameter CLOCK_INC = 100,      /**< clock time diff mhz */
    parameter RESETS = 2,           /**< # of resets */
    parameter RESET_BASE = 200,     /**< time to stay in reset */
    parameter RESET_INC = 100       /**< time diff for other resets */
  )
  (
    output reg [CLOCKS-1:0] clkv,   /**< clock output vector */
    output reg [RESETS-1:0] rstnv,  /**< negative reset output vector */
    output reg [RESETS-1:0] rstv    /**< positive reset output vector */
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
        
        // wait for a certian amount of time, increase based on index * increment
        #((lp_PERIOD+(CLOCK_INC*clk_index))/2);
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


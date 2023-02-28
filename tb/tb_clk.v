//******************************************************************************
/// @file    tb_clk.v
/// @author  JAY CONVERTINO
/// @date    2022.12.05
/// @brief   Test clock stimulator
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

module tb_clk;
  //parameter or local param bus, user and dest width? and files as well? 
  
  localparam BUS_WIDTH  = 1;
  localparam USER_WIDTH = 1;
  localparam DEST_WIDTH = 1;
  
  localparam NUM_CLKS = 2;
  localparam NUM_RSTS = 2;
  
  wire  [NUM_CLKS-1:0]  tb_stim_clk;
  wire  [NUM_RSTS-1:0]  tb_stim_rstn;
  
  clk_stimulus #(
    .CLOCKS(NUM_CLKS), // # of clocks
    .CLOCK_BASE(1000000), // clock time base mhz
    .CLOCK_INC(1000), // clock time diff mhz
    .RESETS(NUM_RSTS), // # of resets
    .RESET_BASE(2000), // time to stay in reset
    .RESET_INC(100) // time diff for other resets
  ) clk_stim (
    //clk out ... maybe a vector of clks with diff speeds.
    .clkv(tb_stim_clk),
    //rstn out ... maybe a vector of rsts with different off times
    .rstnv(tb_stim_rstn),
    .rstv()
  );
  
  // vcd dump command
  initial begin
    $dumpfile ("tb_clk.vcd");
    $dumpvars (0, tb_clk);
    #1;
  end
  
  //copy pasta, no way to set runtime... this works in vivado as well.
  initial begin
    #1_000_000; // Wait a long time in simulation units (adjust as needed).
    $display("END SIMULATION");
    $finish;
  end
  
endmodule


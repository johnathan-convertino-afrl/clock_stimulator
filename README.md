# AFRL Clock Stimulator for AXIS
## AXIS Clock Stimulator modules
---

   author: Jay Convertino   
   
   date: 2022.08.10  
   
   details: AXIS Clock Stimulator, create multiple clocks and resets for testing.   
   
   license: MIT   
   
---

![rtl_img](./rtl.png)

### IP USAGE
#### INSTRUCTIONS

This modules creates multiple clocks and multiple negative or positive resets.  
The module outputs a vector based on the number requested.

#### PARAMETERS

* CLOCKS : 2 : # of clocks
* CLOCK_BASE : 1000000 : clock time base mhz
* CLOCK_INC : 100 : clock time diff mhz
* RESETS : 2 : # of resets
* RESET_BASE : 200 : time to stay in reset
* RESET_INC : 100 : time diff for other resets

### COMPONENTS
#### SRC

* tm_stim_clk.v
  
#### TB

* tb_clk.v

### fusesoc

* fusesoc_info.core created.
* Simulation uses icarus to run data through the core.

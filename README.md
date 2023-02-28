# AFRL Clock Stimulator for AXIS
### AXIS Clock Stimulator modules
---

   author: Jay Convertino   
   
   date: 2022.08.10  
   
   details: AXIS Clock Stimulator, create multiple clocks and resets for testing.   
   
   license: MIT   
   
---

### IP USAGE
#### INSTRUCTIONS

This modules creates multiple clocks and multiple negative or positive resets.  
The module outputs a vector based on the number requested.

#### PARAMETERS

* CLOCKS : 2 : # of clocks
* CLOCK_BASE : 1000000 : clock time base mhz
* CLOCK_INC : 100 : clock time diff mhz, only for async mode.
* CLOCK_ASYNC : 0 : if set to anything other than 0, clock will be async vs sync. 
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

#### TARGETS

* RUN WITH: (fusesoc run --target=sim VENDER:CORE:NAME:VERSION)
  - default (for IP integration builds)
  - sim

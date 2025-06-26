# AFRL Clock Stimulator for AXIS
### AXIS Clock Stimulator modules
---

![image](docs/manual/img/AFRL.png)

---

   author: Jay Convertino   
   
   date: 2022.08.10  
   
   details: AXIS Clock Stimulator, create multiple clocks and resets for testing.   
   
   license: MIT   
   
---

### Version
#### Current
  - V1.0.0 - initial release

#### Previous
  - none

### DOCUMENTATION
  For detailed usage information, please navigate to one of the following sources. They are the same, just in a different format.

  - [clock_stimulator.pdf](docs/manual/clock_stimulator.pdf)
  - [github page](https://johnathan-convertino-afrl.github.io/clock_stimulator/)

### PARAMETERS

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

### FUSESOC

* fusesoc_info.core created.
* Simulation uses icarus to run data through the core.

#### Targets

* RUN WITH: (fusesoc run --target=sim VENDER:CORE:NAME:VERSION)
  - default (for IP integration builds)
  - sim

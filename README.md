# Wrapping ReadMe  
### QDT 2015 April 9  
### Tim Szewczyk  

## File descriptions  
- 01-Main.R: Main wrapper script. Set parameters, run simulation  
- 02-FnSim.R: Main simulation functions used by 01-Main.R  
- 03-FnAux.R: Other functions used by 01-Main.R and 02-FnSim.R  
- 04-Figs.R: Make figures  
  
## Benefits of wrapping  
This set up is useful if you're generating or using a lot of data - for example, running thousands of simulations, exploring a range of parameter spaces, etc. The goal is to minimize human error, maximize transparency, and maximize repeatability. This can also be easily integrated with UNIX to speed up the simulations (see 05-UnixAndR.md) and allow for using other machines remotely. Finally, if you want to show several specific parameter sets in figures or something like that, you can have [one constant core script with several wrapper scripts that load specific parameter or data sets and rely on the core script] instead of [multiple versions of the core script]. So if you need to change anything on the main script, you only need to do it once instead of for each parameter/data set.
  
## Beware  
The scripts will overwrite files if they're set to. Be careful.  
  
## How it works  
The wrapper script The functions used are in 02_Fns_Sim.R and 03_Fns_Aux.R. To run the simulations, you only need to interact with this script - everything else happens behind the scenes, making for cleaner, more organized scripts. Additionally, the parameters and simulation output are stored and can be loaded automatically. 
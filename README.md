# Wrapping ReadMe  
### QDT 2015 April 9  
### Tim Szewczyk  

## File descriptions  
- 01-Main.R: Main wrapper script. Set parameters, run simulation  
- 02-FnSim.R: Main simulation functions used by 01-Main.R  
- 03-FnAux.R: Other functions used by 01-Main.R and 02-FnSim.R  
- 04-Figs.R: Make figures  
- 05-UnixAndR.md: How to run R scripts from the command line  
- 06-HandyFns.R: List of handy R functions  
  
## Benefits of wrapping  
This set up is useful if you're generating or using a lot of data - for example, running thousands of simulations, exploring a range of parameter spaces, etc. There are a bunch of benefits:  
- automation is maximized  
- human error is minimized  
  - no copypasta  
  - no spreadsheet mess arounds  
  - only one place to change simulation code instead of for each parameter set  
- transparency is maximized  
- repeatability is maximized  
- forces you to be organized  
- forces you to have a better workflow  
- scripts are clean and less embarrassing to publish  
- easy integration with UNIX for faster simulations  
- easy transition to remote computing  
  
## Beware  
The scripts will overwrite files without warnings if they're set to do that. Be careful.  
  
## How it works  
The simulation steps are stored as a function with an argument for the parameters. The wrapper is a short script where you set the parameters, run the simulation function, and save the output. To run the simulations, you only need to interact with this script - everything else happens behind the scenes, making for cleaner, more organized, more automated scripts. Additionally, the parameters and simulation output are stored and can be loaded automatically by other scripts (04-Figs.R). 
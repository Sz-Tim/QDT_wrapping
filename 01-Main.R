# QDT wrapper example
# Wrapper script
################################################################################
# This script sets the parameters and runs the simulation.

##########
## set up workspace
##########

	setwd("~/Desktop/Wrapping/")
	source("02-FnSim.R")
	source("03-FnAux.R")
	set.seed(172)  # for maximum reproducibility


##########
## storage switches
##########

	storeSims <- TRUE	# write abundances, lambdas, parameters to files

##########
## set parameters
##########

	###--- simulation parameters

	
	###--- main parameters
	parList <- list(N0=100,		# initial population size
					K=100,		# carrying capacity
					r=0.5,		# average log(proportional growth rate)
					s2=0.5,		# variance in log(proportional growth rate)
					Ne=0.5,		# quasi-extinction threshold
					sims=1000,	# number of simulations
					maxt=200)	# maximum time
					
	
	###--- meta-parameters
	param <- "s2"	# parameter to vary
	low <- 0.01		# low value for parameter range
	high <- 2		# high value for parameter range
	parLen <- 7		# number of values for varied parameter
	logSeq <- TRUE	# make parameter values distributed along a log scale
	
	
##########
## run simulation
##########
	
	# make a parameter sequence to vary across simulation sets
	parSeq <- makeParSet(param=param, low=low, high=high, 
						 len=parLen, logSeq=logSeq)

	# simulation loop
	dirNum <- 1
	for(p in 1:parLen) {
		
		# update varied parameter
		parList[names(parList)==param] <- parSeq[p]
		
		# simulate
		sim.out <- popSim(parList)
		
		# write data to files
		if(storeSims) {
			writeOutputAndPars(abund.mx=sim.out$N.mx,
							   lam.mx=sim.out$lam.mx,
							   param=param,
							   parList=parList,
							   dirNum=dirNum)
		}
		dirNum <- dirNum + 1
		cat("Finished parameter set", p, "of", parLen, "\n")
	}
	
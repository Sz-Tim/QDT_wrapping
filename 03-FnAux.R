# QDT wrapper example
# Additional functions

##########
## make parameter sequence
##########

	makeParSet <- function(param, low, high, len, logSeq=FALSE) {
		if(logSeq) {
			par.seq <- exp( seq(log(low), log(high), length.out=len) )
		} else {
			par.seq <- seq(low, high, length.out=len)
		}
		return(par.seq)
	}


##########
## write simulation output to csv
##########

	writeOutputAndPars <- function(abund.mx, lam.mx, param, parList, dirNum) {
		
		###--- generate folders if necessary
		# create SimOutput folder if necessary
		if( !file.exists(paste0(getwd(), "/SimOutput")) ) {
			dir.create(paste0(getwd(),"/SimOutput/"))
		}
		
		# create parameter folder if necessary
		if( !file.exists(paste0(getwd(), "/SimOutput/", param)) ) {
			dir.create(paste0(getwd(),"/SimOutput/", param, "/"))
		}
		
		# create run folder if necessary
		rundir <- paste0(getwd(), "/SimOutput/", param, "/run", dirNum, "/")
		if( !file.exists(rundir) ) {
			dir.create(rundir)
		}		
		
		###--- write file
		# write abundance matrix
		write.csv(abund.mx, file=paste0(rundir, "abund.csv"))
		
		# write lambda matrix
		write.csv(lam.mx, file=paste0(rundir, "lam.csv"))
		
		# write parameters
		sink(paste0(rundir, "parameters.R"))  # diverts R's output
		cat("parList <- list(N0=", parList$N0, ", ",
							"K=", parList$K, ", ",
							"r=", parList$r, ", ",
							"s2=", parList$s2, ", ",
							"Ne=", parList$Ne, ", ",
							"sims=", parList$sims, ", ",
							"maxt=", parList$maxt, ")", sep="")
		sink()  # resets the output back to the R Console

	}
	
	
##########	
## retrieve data from files
##########

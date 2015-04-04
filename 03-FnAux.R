# QDT wrapper example
# Additional functions

##########
## make parameter sequence
##########

	makeParSeq <- function(param, low, high, len, logSeq=FALSE) {
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

	writeOutputAndPars <- function(sim.out, param, parList, dirNum) {
		
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
		
		###--- write files
      # write abundance matrix
      write.csv(sim.out$N.mx, file=paste0(rundir, "abund.csv"))
    
      # write lambda matrix
      write.csv(sim.out$lam.mx, file=paste0(rundir, "lam.csv"))
    
      # write pr(extinction) matrix
      write.csv(sim.out$pr.ext, file=paste0(rundir, "prExt.csv"))
    
      # write parameters
      sink(paste0(rundir, "parameters.R"))  # diverts R's output
      cat("parList <- list(N0=", parList$N0, ", ",
          "K=", parList$K, ", ",
          "r=", parList$r, ", ",
          "s2=", parList$s2, ", ",
          "Ne=", parList$Ne, ", ",
          "sims=", parList$sims, ", ",
          "maxt=", parList$maxt, ") \n", # use \n to indicate new line
          "# example of how to start a new line of code", sep="")
      sink()  # resets the output back to the R Console
	}
	
	
##########	
## retrieve data from files
##########

  getPrExt <- function(param) {
    
    ###--- directory and data info
    basedir <- paste0(getwd(), "/SimOutput/", param)
    nDirs <- length(list.files(basedir))
    nTime <- nrow(read.csv(paste0(basedir, "/run1/prExt.csv")))
    n <- nDirs*nTime
    
    ###--- dataframe structure
    df <- data.frame(N0=rep(NA, n),
                     K=rep(NA, n),
                     r=rep(NA, n),
                     s2=rep(NA, n),
                     Ne=rep(NA, n),
                     sims=rep(NA, n),
                     maxt=rep(NA, n),
                     time=rep(NA, n),
                     prExt=rep(NA, n))
    
    ###--- fill out dataframe
    for(d in 1:nDirs) {
      
      # load parameters & csv
      source(paste0(basedir, "/run", d, "/parameters.R"))
      run.df <- read.csv(paste0(basedir, "/run", d, "/prExt.csv"))
      
      # calculate df rows for this run
      dfrows <- (d*nTime-(nTime-1)):(d*nTime)
      
      # fill dataframe
      df$N0[dfrows] <- parList$N0
      df$K[dfrows] <- parList$K
      df$r[dfrows] <- parList$r
      df$s2[dfrows] <- parList$s2
      df$Ne[dfrows] <- parList$Ne
      df$sims[dfrows] <- parList$sims
      df$maxt[dfrows] <- parList$maxt
      df$time[dfrows] <- run.df$time
      df$prExt[dfrows] <- run.df$prExt
    }
    
    return(df)
  }
  

  getAbund <- function(param) {
    
    ###--- directory and data info
    require(plyr)
    require(tidyr)
    basedir <- paste0(getwd(), "/SimOutput/", param)
    nDirs <- length(list.files(basedir))
    
    ###--- list structure
    abund.ls <- vector("list", nDirs)
    
    ###--- fill out list
    for(d in 1:nDirs) {
      
      # load parameters & abundances
      source(paste0(basedir, "/run", d, "/parameters.R"))
      run.df <- read.csv(paste0(basedir, "/run", d, "/abund.csv"))
      
      # convert from wide to tall
      names(run.df) <- c("time", 1:(ncol(run.df)-1))
      run.df <- gather(run.df, key=sim, value=abund, 2:ncol(run.df))
      
      # add parameters to df
      run.df$N0 <- rep(parList$N0, nrow(run.df))
      run.df$K <- rep(parList$K, nrow(run.df))
      run.df$r <- rep(parList$r, nrow(run.df))
      run.df$s2 <- rep(parList$s2, nrow(run.df))
      run.df$Ne <- rep(parList$Ne, nrow(run.df))
      
      # store run.df in list
      abund.ls[[d]] <- run.df
    }
    
    ###--- reformat list into a dataframe
    return(ldply(abund.ls))
  }

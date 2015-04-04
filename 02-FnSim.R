# QDT wrapper example
# Main simulation function

popSim <- function(parList) {
	
	###--- unpack parameters
		N0 <- parList$N0
		K <- parList$K
		r <- parList$r
		s2 <- parList$s2
		Ne <- parList$Ne
		sims <- parList$sims
		maxt <- parList$maxt
		
	
	###--- initialize objects
		# abundance
		N.mx <- matrix(nrow=maxt+1, ncol=sims)
		N.mx[1,] <- N0
		
		# actual growth rates
		lam.mx <- matrix(nrow=maxt, ncol=sims)
	
	###--- run simulations
		for(s in 1:sims) {
			for(i in 1:maxt) {
				
				# generate actual growth rate
				expected <- r*(1 - N.mx[i,s]/K)
				lam.t <- exp(rnorm(1, expected, sqrt(s2)))
				
				# grow population
				N.mx[i+1, s] <- N.mx[i,s]*lam.t
				
				# enforce extinction
				if(N.mx[i+1, s] < Ne) {
					N.mx[i+1, s] <- 0
					lam.t <- 0
				}
				
				# store growth rate
				lam.mx[i,s] <- lam.t
			}
		}
		
	###--- calculate extinctions
		ext.mx <- N.mx == 0
		pr.ext <- data.frame(prExt=rowSums(ext.mx)/sims,
                         time=1:(maxt+1))
	
	return(list(N.mx=N.mx, 
				lam.mx=lam.mx, 
				ext.mx=ext.mx, 
				pr.ext=pr.ext))
}
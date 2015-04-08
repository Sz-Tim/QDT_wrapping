# Wrapping: main simulation function
# QDT 2015 April 09
# Tim Szewczyk

# This function simulates populations in discrete time using a stochastic 
# version of the Ricker model to implement density dependence. Each year, the
# abundance is calculated as N[t+1] = N[t]*lambda[t] where the growth rate
# lambda[t] is ~exp( Norm(mean=r*(1-N[t]/K), variance=s2) ).

# The function needs the list of parameters and outputs a list including:
# - N.mx: simulated abundances with rows=time, cols=sims
# - lam.mx: actual proportional growth rates with rows=time, cols=sims
# - ext.mx: T/F where T=extinction, with rows=time, cols=sims
# - pr.ext: proportion of populations extinct, with rows=time

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
			}  # close time loop
		}  # close sim loop
		
	###--- calculate extinctions
		ext.mx <- N.mx == 0
		pr.ext <- data.frame(prExt=rowSums(ext.mx)/sims,
                         time=1:(maxt+1))
	
	return(list(N.mx=N.mx, 
              lam.mx=lam.mx,
              ext.mx=ext.mx,
              pr.ext=pr.ext))
}

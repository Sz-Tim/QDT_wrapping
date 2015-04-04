# QDT wrapper example
# Making figures with stored data


##########
## set up workspace
##########

  library(plyr); library(tidyr); library(ggplot2); theme_set(theme_bw())
  source("03-FnAux.R")
  
##########
## probability of extinction & r
##########

  rExt.df <- getPrExt(param="r")
  rExt.df$r <- factor(rExt.df$r)
  ggplot(rExt.df, aes(x=time, y=prExt, colour=r)) + ylim(0,1) +
    geom_line(size=1) + scale_colour_brewer(type="div", palette=3) +
    labs(x="Time", y="Probability of extinction")

  
##########
## probability of extinction & s2
##########

  s2Ext.df <- getPrExt(param="s2")
  s2Ext.df$s2 <- factor(s2Ext.df$s2)
  ggplot(s2Ext.df, aes(x=time, y=prExt, colour=s2)) + ylim(0,1) +
    geom_line(size=1) + scale_colour_brewer(type="seq") +
    labs(x="Time", y="Probability of extinction")


##########
## population trajectories & r
##########
  
  rAbund.df <- getAbund(param="r")
  rAbund.df$r <- factor(rAbund.df$r)
  ggplot(rAbund.df, aes(x=time, y=abund, group=sim)) + 
    geom_line(alpha=0.1) + facet_wrap(~r) + 
    labs(x="Time", y="Abundance")

  ggplot(rAbund.df, aes(x=time, y=log(abund+1), group=sim)) + 
    geom_line(alpha=0.05) + facet_wrap(~r) + 
    labs(x="Time", y="log(Abundance)")


##########
## population trajectories & s2
##########

  s2Abund.df <- getAbund(param="s2")
  s2Abund.df$s2 <- factor(s2Abund.df$s2)
  ggplot(s2Abund.df, aes(x=time, y=abund, group=sim)) + 
    geom_line(alpha=0.2) + facet_wrap(~s2) + 
    labs(x="Time", y="Abundance")

  ggplot(s2Abund.df, aes(x=time, y=log(abund+1), group=sim)) + 
    geom_line(alpha=0.2) + facet_wrap(~s2) + 
    labs(x="Time", y="log(Abundance)")


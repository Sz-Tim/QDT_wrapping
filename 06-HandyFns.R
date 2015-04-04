# QDT wrapper example
# Handy R functions

##########
## data manipulation
##########

library(plyr)  # really useful for converting object types, summarizing, etc
?ldply  # converts a list into a dataframe
?ddply  # converts a dataframe to a dataframe with some specified modifications


##########
## R and your computer
##########

?source  # runs an R script. Often used for fns, but can be used to set params
?sink  # diverts R's output to a file or other location
?cat  # prints output just as text. Useful with sink.
?file.exists  # does a file or folder exist?
?dir.create  # creates a folder
?list.dirs  # what folders are within this one? Includes all sublevels
?list.files  # what files/folders are directly in this folder?


##########
## miscellaneous
##########

?paste0  # just like paste(), but the default is sep="" instead of sep=" "
?set.seed  # set starting point for R's pseudo-random number generator
?expand.grid  # make dataframe of all combinations of supplied vectors
?'<<-'  # inside a function, assigns globally instead of just within function
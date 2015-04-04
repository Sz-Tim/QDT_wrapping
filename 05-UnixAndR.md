# Running simulations from the command line  
### The very, very basics  
### QDT 2015 April 9  
### Tim Szewczyk  
  
If you're running simulations that take a lot of time, this is one way to speed them up a little bit. At least that's what I remember Sam saying. Something about how there are fewer steps going on with programs talking to each other since you're cutting out R, who normally asks your computer to do the operations, and asking the computer yourself. You can also use the same commands to run the script remotely on another computer. It's actually pretty easy and you can download apps for your phone so you can make a computer run a script from your phone and feel really cool. All of the commands below are for the Terminal window - not to be run in R.   
  
#### Set the directory  
Open up a window in the terminal and set the directory.  
`cd ~/Desktop/QDT_wrap`  
In case you forgot the name of the file:  
`ls`  
  
#### Run the R script and see the progress  
`Rscript 01-Main.R`  
  
#### Run the R script and don't show the progress  
`R CMD BATCH 01-Main.R`  
Instead of showing the output in the terminal window, it creates a file called "01-Main.Rout" that shows everything you'd see in the R Console window.  
`cat 01-Main.Rout`

#!/usr/bin/env Rscript
options(stringAsfactors = FALSE, useFancyQuotes = FALSE)

# Taking the command line arguments
args <- commandArgs(trailingOnly = TRUE)

if(length(args)==0)stop("No file has been specified! Please select a file for performing grouping!\n")
require(xcms)
previousEnv<-NA
output<-NA
bw<-15
mzwid=0.005
for(arg in args)
{
  argCase<-strsplit(x = arg,split = "=")[[1]][1]
  value<-strsplit(x = arg,split = "=")[[1]][2]
  if(argCase=="input")
  {
    previousEnv=as.character(value)
  }
  if(argCase=="bandwidth")
  {
    bw=as.numeric(value)
  }
  if(argCase=="mzwid")
  {
    mzwid=as.numeric(value)
  }
  if(argCase=="output")
  {
    output=as.character(value)
  }
  
}
if(is.na(previousEnv) | is.na(output)) stop("Both input and output need to be specified!\n")

load(file = previousEnv)

toBeGrouped<-get(varNameForNextStep)

xcmsSetGrouped<-  group(toBeGrouped,bw=bw,mzwid=mzwid)

preprocessingSteps<-c(preprocessingSteps,"Group")

varNameForNextStep<-as.character("xcmsSetGrouped")

save(list = c("xcmsSetGrouped","preprocessingSteps","varNameForNextStep"),file = output)

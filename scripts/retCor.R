#!/usr/bin/env Rscript
options(stringAsfactors = FALSE, useFancyQuotes = FALSE)

# Taking the command line arguments
args <- commandArgs(trailingOnly = TRUE)

if(length(args)==0)stop("No file has been specified! Please select a file for performing RT correction!\n")
require(xcms)
previousEnv<-NA
output<-NA
method="obiwarp"
for(arg in args)
{
  argCase<-strsplit(x = arg,split = "=")[[1]][1]
  value<-strsplit(x = arg,split = "=")[[1]][2]
  if(argCase=="input")
  {
    previousEnv=as.character(value)
  }
  if(argCase=="method")
  {
    method=as.character(value)
  }
  if(argCase=="output")
  {
    output=as.character(value)
  }
  
}
if(is.na(previousEnv) | is.na(output)) stop("Both input and output need to be specified!\n")

load(file = previousEnv)

toBeRTCorrected<-get(varNameForNextStep)

xcmsSetRTcorrected<-  retcor(toBeRTCorrected,method=method)

preprocessingSteps<-c(preprocessingSteps,"RTCorrection")

varNameForNextStep<-as.character("xcmsSetRTcorrected")

save(list = c("xcmsSetRTcorrected","preprocessingSteps","varNameForNextStep"),file = output)


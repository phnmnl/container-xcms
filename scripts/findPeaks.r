#!/usr/bin/env Rscript
options(stringAsfactors = FALSE, useFancyQuotes = FALSE)

# Taking the command line arguments
args <- commandArgs(trailingOnly = TRUE)

if(length(args)==0)stop("No file has been specified! Please select a file for performing peak picking!\n")
require(xcms)
RawFiles<-NA
output<-NA
ppm=10
peakwidthLow=4
peakwidthHigh=30
noise=1000
polarity<-"pos"
for(arg in args)
{
  argCase<-strsplit(x = arg,split = "=")[[1]][1]
  value<-strsplit(x = arg,split = "=")[[1]][2]
  if(argCase=="input")
  {
    RawFiles=as.character(value)
  }
  if(argCase=="ppm")
  {
    ppm=as.numeric(value)
  }
  if(argCase=="peakwidthLow")
  {
    peakwidthLow=as.numeric(value)
  }
  if(argCase=="peakwidthHigh")
  {
    peakwidthHigh=as.numeric(value)
  }
  if(argCase=="noise")
  {
    noise=as.numeric(value)
  }
  if(argCase=="polarity")
  {
    polarity=as.character(value)
  }
  if(argCase=="output")
  {
    output=as.character(value)
  }
 
}
if(is.na(RawFiles) | is.na(output)) stop("Both input and output need to be specified!\n")
require(xcms)
massTracesXCMSSet<-xcmsSet(RawFiles,polarity = polarity,
        method = "centWave",
        ppm=ppm,
        peakwidth=c(peakwidthLow,peakwidthHigh),
        noise=noise)
# get original name of mz file
name.parts <- unlist(strsplit(gsub(".*name=\"", "", grep('<sourceFile ', readLines(RawFiles), value=T)[1]), c("\\.")))
attributes(attributes(massTracesXCMSSet)[[".processHistory"]][[1]])$origin <- paste(name.parts[-length(name.parts)], collapse=".")

preprocessingSteps<-c("FindPeaks")
varNameForNextStep<-as.character("massTracesXCMSSet")
save(list = c("massTracesXCMSSet","preprocessingSteps","varNameForNextStep"),file = output)

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
sampleClass<-NA
realFileName<-NA
phenoFile<-NA
phenoDataColumn<-NA
for(arg in args)
{
  argCase<-strsplit(x = arg,split = "=")[[1]][1]
  value<-strsplit(x = arg,split = "=")[[1]][2]
  if(argCase=="input")
  {
    RawFiles=as.character(value)
  }
  if(argCase=="realFileName")
  {
    realFileName=as.character(value)
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
  if(argCase=="sampleClass")
  {
    sampleClass=as.character(value)
  }
  if(argCase=="phenoFile")
  {
    phenoFile=as.character(value)
  }
  if(argCase=="phenoDataColumn")
  {
    phenoDataColumn=as.character(value)
  }
  if(argCase=="output")
  {
    output=as.character(value)
  }
 
}
if(is.na(RawFiles) | is.na(output)) stop("Both input and output need to be specified!\n")
require(xcms)
massTracesXCMSSet<-NA
if(is.na(sampleClass))
{
massTracesXCMSSet<-xcmsSet(RawFiles,polarity = polarity,
        method = "centWave",
        ppm=ppm,
        peakwidth=c(peakwidthLow,peakwidthHigh),
        noise=noise)
}else{
massTracesXCMSSet<-xcmsSet(RawFiles,polarity = polarity,
        method = "centWave",
        ppm=ppm,
        peakwidth=c(peakwidthLow,peakwidthHigh),
        noise=noise,sclass = sampleClass)
}
# get original name of mz file
name.parts <- unlist(strsplit(gsub(".*name=\"", "", grep('<sourceFile ', readLines(RawFiles), value=T)[1]), c("\\.")))
attributes(attributes(massTracesXCMSSet)[[".processHistory"]][[1]])$origin <- paste(name.parts[-length(name.parts)], collapse=".")

# set the original file name
realFileName<-gsub(pattern = "Galaxy.*-\\[|\\].*",replacement = "",x = realFileName)
rownames(massTracesXCMSSet@phenoData)<-realFileName

# set phenotype if demanded
if(!is.na(phenoDataColumn) && !is.na(phenoFile))
{
fileNameMap<-read.csv(phenoFile,stringsAsFactors = F,header = T)
massTracesXCMSSet@phenoData[1]<-fileNameMap[fileNameMap[,1]==rownames(massTracesXCMSSet@phenoData),phenoDataColumn]
}





preprocessingSteps<-c("FindPeaks")
varNameForNextStep<-as.character("massTracesXCMSSet")
save(list = c("massTracesXCMSSet","preprocessingSteps","varNameForNextStep"),file = output)

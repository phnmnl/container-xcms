#!/usr/bin/env Rscript

options(stringAsfactors = FALSE, useFancyQuotes = FALSE)

# Taking the command line arguments
args <- commandArgs(trailingOnly = TRUE)

if(length(args)==0)stop("No file has been specified! Please select a file for pheno annotation!\n")

require(xcms)

phenoDataColumn<-"phenoData"


previousEnv<-NA
output<-NA
inputCSV<-NA
for(arg in args)
{
  argCase<-strsplit(x = arg,split = "=")[[1]][1]
  value<-strsplit(x = arg,split = "=")[[1]][2]
  if(argCase=="input")
  {
    previousEnv=as.character(value)
  }
   if(argCase=="inputCSV")
  {
    inputCSV=as.character(value)
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


if(is.na(previousEnv) | is.na(output) | is.na(inputCSV)) stop("Both input and output need to be specified!\n")

load(file = previousEnv)
inputDataSet<-get(varNameForNextStep)

fileNameMap<-read.csv(inputCSV)

if(class(inputDataSet)=="xcmsSet")
{
  tmpDataFrame<-c()
  tmpPhenodata<-data.frame(inputDataSet@phenoData,stringsAsFactors = F)
  tmpPhenodata[,1]<-as.character(tmpPhenodata[,1])
  for(i in 1:nrow(inputDataSet@phenoData))
  {
    
    PhenoIndex<-which(fileNameMap==rownames(tmpPhenodata)[i], arr.ind = TRUE)[1]   
    newPheno<-as.character(fileNameMap[PhenoIndex,phenoDataColumn])
    tmpPhenodata[PhenoIndex,]<-newPheno
    
    
  }
  tmpPhenodata[,1]<-factor(tmpPhenodata[,1])
  inputDataSet@phenoData<-tmpPhenodata
  
}
xcmsSetPhenoSet<-inputDataSet

preprocessingSteps<-c(preprocessingSteps,"setPheno")

varNameForNextStep<-as.character("xcmsSetPhenoSet")

save(list = c("xcmsSetPhenoSet","preprocessingSteps","varNameForNextStep"),file = output)
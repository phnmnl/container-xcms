#!/usr/bin/env R

#source("http://bioconductor.org/biocLite.R")
#biocLite("xcms", dep=T, ask=F)

## Some code taken and adapted from: https://github.com/nturaga/bioc-galaxy-integration/

# Setup R error handling to go to stderr
options(show.error.messages=F, error=function(){cat(geterrmessage(),file=stderr());q("no",1,F)})

# Set proper locale
loc <- Sys.setlocale("LC_MESSAGES", "en_US.UTF-8")

# Import library
library("getopt")
options(stringAsfactors = FALSE, useFancyQuotes = FALSE)

# Take in trailing command line arguments
args <- commandArgs(trailingOnly = TRUE)

# get options, using the spec as defined by the enclosed list.
# we read the options from the default: commandArgs(TRUE).
option_specification = matrix(c(
  'input', 'i', 2, 'character',
  'output', 'o', 2, 'character'
), byrow=TRUE, ncol=4);

# Parse options
options = getopt(option_specification);

# Print options to see what is going on
cat("\n input: ",options$input)
cat("\n output: ",options$output)

# 
library(xcms)
xsetraw <- xcmsRaw(input)
xchrom <- plotChrom(xsetraw, base=TRUE)

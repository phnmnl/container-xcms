#!/bin/bash

# Install wget
apt-get update -y && apt-get install -y --no-install-recommends wget ca-certificates

# Download testing data
wget -O "neg-MM8_1-A,1_01_376.mzML" "https://github.com/phnmnl/container-xcms/raw/develop/neg-MM8_1-A%2C1_01_376.mzML"
wget -O "neg-MM8_1-A,1_01_376.csv" "https://github.com/phnmnl/container-xcms/raw/develop/neg-MM8_1-A%2C1_01_376.csv"

# Execute R testing script
/usr/local/bin/test_output.r "neg-MM8_1-A,1_01_376.mzML" "neg-MM8_1-A,1_01_376.csv"

exit $?

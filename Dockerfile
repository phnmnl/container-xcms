FROM container-registry.phenomenal-h2020.eu/phnmnl/rbase:latest

MAINTAINER PhenoMeNal-H2020 Project (phenomenal-h2020-users@googlegroups.com)

LABEL software=xcms
LABEL software.version=1.50.1
LABEL version=0.4
LABEL Description="XCMS: Framework for processing and visualization of chromatographically separated and single-spectra mass spectral data."

# Install packages for compilation
RUN apt-get -y update
RUN apt-get -y --no-install-recommends install make gcc gfortran g++ libnetcdf-dev

# Install XCMS
RUN R -e 'source("https://bioconductor.org/biocLite.R"); biocLite("xcms")'

# De-install not needed packages
RUN apt-get -y --purge --auto-remove remove make gcc gfortran g++

# Clean-up
RUN apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

# Add scripts to container
ADD save_chromatogram.r /usr/local/bin/save_chromatogram.r
ADD show_chromatogram.r /usr/local/bin/show_chromatogram.r
ADD scripts/fillPeaks.R /usr/local/bin/fillPeaks.r
ADD scripts/findPeaks.R /usr/local/bin/findPeaks.r
ADD scripts/group.R /usr/local/bin/group.r
ADD scripts/retCor.R /usr/local/bin/retCor.r
ADD scripts/xcmsCollect.R /usr/local/bin/xcmsCollect.r
ADD test_output.r /usr/local/bin/test_output.r
RUN chmod +x /usr/local/bin/*.r

# Add testing to container
ADD runTest1.sh /usr/local/bin/runTest1.sh

# Define Entry point script
#ENTRYPOINT [ "Rscript" ]
#CMD [ "/usr/local/bin/show_chromatogram.r" ]

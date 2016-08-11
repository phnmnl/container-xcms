FROM docker-registry.phenomenal-h2020.eu/phnmnl/ipo

MAINTAINER Kristian Peters <kpeters@ipb-halle.de>

LABEL Description="Execute an R script for testing mzML files."

# Add scripts folder to container
ADD show_chromatogram.r /show_chromatogram.r
RUN chmod 755 /show_chromatogram.r

# Define Entry point script
#ENTRYPOINT ["Rscript"]

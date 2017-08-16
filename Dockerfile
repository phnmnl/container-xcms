FROM container-registry.phenomenal-h2020.eu/phnmnl/rbase:v3.4.1-1xenial0_cv0.2.12

MAINTAINER PhenoMeNal-H2020 Project (phenomenal-h2020-users@googlegroups.com)

LABEL software="XCMS"
LABEL software.version="1.52.0"
LABEL version="0.7"
LABEL Description="XCMS: Framework for processing and visualization of chromatographically separated and single-spectra mass spectral data."
LABEL website="https://github.com/sneumann/xcms"
LABEL documentation="https://github.com/phnmnl/container-xcms/blob/master/README.md"
LABEL license="https://github.com/phnmnl/container-midcor/blob/master/License.txt"
LABEL tags="Metabolomics"

# Install packages for compilation
RUN apt-get -y update && apt-get -y --no-install-recommends install make gcc gfortran g++ libnetcdf-dev libxml2-dev libblas-dev liblapack-dev && \
    R -e 'source("https://bioconductor.org/biocLite.R"); biocLite("xcms")' && \
    apt-get -y --purge --auto-remove remove make gcc gfortran g++ libblas-dev liblapack-dev && \
    apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

# Add scripts to container
ADD scripts/*.r /usr/local/bin/
RUN chmod +x /usr/local/bin/*.r

# Add testing to container
ADD runTest1.sh /usr/local/bin/runTest1.sh

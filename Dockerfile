FROM container-registry.phenomenal-h2020.eu/phnmnl/ipo:dev_v1.7.5_cv0.2.28
MAINTAINER PhenoMeNal-H2020 Project (phenomenal-h2020-users@googlegroups.com)

LABEL software=xcms
LABEL software.version=1.50.1
LABEL version=0.1
LABEL Description="XCMS: Framework for processing and visualization of chromatographically separated and single-spectra mass spectral data."

# Add scripts folder to container
ADD show_chromatogram.r /usr/local/bin/show_chromatogram.r
RUN chmod +x /usr/local/bin/show_chromatogram.r

# Define Entry point script
#ENTRYPOINT ["Rscript"]

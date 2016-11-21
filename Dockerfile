FROM docker-registry.phenomenal-h2020.eu/phnmnl/ipo

MAINTAINER PhenoMeNal-H2020 Project (phenomenal-h2020-users@googlegroups.com)

LABEL Description="XCMS: Framework for processing and visualization of chromatographically separated and single-spectra mass spectral data."

# Add scripts folder to container
#ADD show_chromatogram.r /show_chromatogram.r
#RUN chmod 755 /show_chromatogram.r

# Define Entry point script
#ENTRYPOINT ["Rscript"]

FROM container-registry.phenomenal-h2020.eu/phnmnl/ipo

LABEL software=xcms
LABEL software.version=1.0.0
LABEL version=0.1

LABEL Description="XCMS: Framework for processing and visualization of chromatographically separated and single-spectra mass spectral data."

MAINTAINER PhenoMeNal-H2020 Project (phenomenal-h2020-users@googlegroups.com)



# Add scripts folder to container
#ADD show_chromatogram.r /show_chromatogram.r
#RUN chmod 755 /show_chromatogram.r

# Define Entry point script
#ENTRYPOINT ["Rscript"]

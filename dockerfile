# Use a minimal Alpine image as the base
FROM alpine:latest

# Copy the texlive profile for full installation
COPY texlive.profile /tmp/texlive.profile

# Install dependencies and full TeX Live
RUN apk add --no-cache \
        perl \
        fontconfig \
        ghostscript \
        imagemagick \
        wget 
RUN wget -qO- http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar -xz 
ENV TEXLIVE_INSTALL_ENV="TEXLIVE_DOWNLOAD_ARGS='--limit-rate=0 --retry-connrefused'"
RUN cd install-tl-* && ./install-tl --profile=/tmp/texlive.profile 
RUN rm -rf /tmp/texlive.profile install-tl-*
# Set the TeX Live path for pdflatex and other binaries
ENV PATH="/usr/local/texlive/2023/bin/x86_64-linuxmusl:$PATH"
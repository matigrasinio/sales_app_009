# Choose your base image
FROM rocker/r-ver:4.2.0

RUN apt-get update && apt-get install -y \
      libcurl4-gnutls-dev \
      libssl-dev \
      libpng-dev \
      vim \
      nano \
      libxml2 \
      libxml2-dev \
      curl \
      gnupg2 \
      build-essential libssl-dev \
      libz-dev \
      libsodium-dev

RUN useradd -ms /bin/bash devel

ENV RENV_VERSION 0.17.0
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

RUN mkdir /renv
RUN chown -R devel:devel /renv
RUN chown -R devel:devel /usr/local/lib/R/site-library
USER devel

WORKDIR /project
COPY renv.lock /tmp/renv.lock

ENV RENV_PATHS_ROOT /renv
ENV RENV_PATHS_LIBRARY /renv/project
ENV RENV_PATHS_CACHE /renv/cache
ENV RENV_PATHS_LOCKFILE /project/renv.lock

RUN R -e "renv::restore(prompt = FALSE, lockfile = '/tmp/renv.lock')"

# Use a base image with R and Python installed
FROM rocker/r-ver:4.1.2

# Install necessary R libraries
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff5-dev \
    libudunits2-dev \
    libgdal-dev \
    libproj-dev \
    libgeos-dev \
    libnetcdf-dev \
    libcairo2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install necessary Python libraries
COPY requirements.txt /tmp/requirements.txt
RUN apt-get update && apt-get install -y \
    python3-pip \
    && pip3 install --no-cache-dir -r /tmp/requirements.txt \
    && rm -rf /var/lib/apt/lists/* /tmp/*

# Install required R packages
RUN R -e "install.packages(c('shiny', 'ggplot2'), repos='http://cran.rstudio.com/')"

# Copy the Shiny app code into the Docker image
COPY app.R /srv/shiny-server/

# Expose the Shiny port
EXPOSE 3838

# Command to run the Shiny app
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/', host='0.0.0.0', port=3838)"]


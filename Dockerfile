FROM trestletech/plumber
MAINTAINER Matthew Emery <me@matthewemery.ca>

RUN R -e "install.packages(c('devtools', 'packrat'), repos = 'http://cran.us.r-project.org')"

ADD ./horsekickeR /home/user/horsekickeR

WORKDIR /home/user/horsekickeR

RUN R -e 'devtools::install_deps(dependencies = TRUE, upgrade = "never")'

RUN R -e 'devtools::install()'

EXPOSE 8000

CMD ["Rscript", "exec/plumber.R"]

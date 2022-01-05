FROM rapporteket/dev:nightly

LABEL maintainer "Are Edvardsen <are.edvardsen@helse-nord.no>"

# add registry dev config and R pkg dependencies
COPY --chown=rstudio:rstudio db.yml /home/rstudio/rap_config/
RUN cat /home/rstudio/rap_config/db.yml >> /home/rstudio/rap_config/dbConfig.yml \
    && rm /home/rstudio/rap_config/db.yml \
    && R -e "install.packages(c('DT', \
                                'kableExtra',\
                                'knitr',\
                                'testthat',\
                                'xtable',\
                                'shinyjs',\
                                'rapFigurer',\
                                'tidyverse',\
                                'rapbase'))" \
    && R -e "remotes::install_github(c('Rapporteket/rapbase', 'Rapporteket/rapFigurer'))"

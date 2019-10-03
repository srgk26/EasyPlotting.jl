## Using Julia v1.2.0 docker image
FROM julia:1.2.0

## Running necessary build commands to setup EasyPlotting.jl
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install unzip libgtk-3-dev gettext python3-pip
RUN pip3 install seaborn
RUN julia -e 'using Pkg; Pkg.add(["PlotlyJS", "ORCA", "ImageMagick", "EasyPlotting"])'

## Run EasyPlotting.easymain() when running this docker image
CMD julia -e 'using EasyPlotting; retry(EasyPlotting.easymain::Function, delays=ExponentialBackOff(n=5, first_delay=5, max_delay=10))()'

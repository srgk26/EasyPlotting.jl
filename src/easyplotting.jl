module easyplotting ## Define easyplotting module

using Blink, Interact, XLSX, CSV, DelimitedFiles, DataFrames, Plots, PlotlyJS, Seaborn, Conda, FileIO, ImageView ## Importing required libraries for all downstream functions

## Include all source scripts
include(joinpath(pathof(easyplotting)[1:end-15], "mainpage.jl")) ## Include 'mainpage.jl'
include(joinpath(pathof(easyplotting)[1:end-15], "Heatmap/easyheatmap.jl")) ## Include 'easyheatmap.jl'
include(joinpath(pathof(easyplotting)[1:end-15], "Scatterplot/easyscatterplot.jl")) ## Include 'easyscatterplot.jl'
include(joinpath(pathof(easyplotting)[1:end-15], "Linegraph/easylinegraph.jl")) ## Include 'easylinegraph.jl'
include(joinpath(pathof(easyplotting)[1:end-15], "Histogram/easyhistogram.jl")) ## Include 'easyhistogram.jl'
include(joinpath(pathof(easyplotting)[1:end-15], "Barchart/easybarchart.jl")) ## Include 'easybarchart.jl'
include(joinpath(pathof(easyplotting)[1:end-15], "BoxandWhisker/easyboxandwhisker.jl")) ## Include 'easyboxandwhisker.jl'
include(joinpath(pathof(easyplotting)[1:end-15], "Piechart/easypiechart.jl")) ## Include 'easypiechart.jl'
include(joinpath(pathof(easyplotting)[1:end-15], "Violinplot/easyviolinplot.jl")) ## Include 'easyviolinplot.jl'

end #module

module EasyPlotting ## Define EasyPlotting module

using Blink, Interact, XLSX, CSV, DelimitedFiles, DataFrames, StatsPlots, PlotlyJS, Seaborn, Conda, FileIO, ImageView ## Importing required libraries for all downstream functions

## Include all source scripts
include("easymain.jl")
include("easybarchart.jl")
include("easyboxandwhisker.jl")
include("easyheatmap.jl")
include("easyhistogram.jl")
include("easylinegraph.jl")
include("easypiechart.jl")
include("easyscatterplot2d.jl")
include("easyscatterplot3d.jl")
include("easystripplot.jl")
include("easyviolinplot.jl")

end #module

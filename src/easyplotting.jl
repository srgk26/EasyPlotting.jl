module easyplotting ## Define easyplotting module

using Blink, Interact, XLSX, CSV, DelimitedFiles, DataFrames, Plots, PlotlyJS, Seaborn, Conda, FileIO, ImageView ## Importing required libraries for all downstream functions

## Include all source scripts
joinpath(pathof(easyplotting)[1:end-15], "mainpage.jl") ## Include 'mainpage.jl'
joinpath(pathof(easyplotting)[1:end-15], "Heatmap/easyheatmap.jl") ## Include 'easyheatmap.jl'

end #module

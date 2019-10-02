ENV["PYTHON"]="" ## Configuring PyCall to use Julia-specific Python distribution via the Conda.jl package
using Pkg; Pkg.build("PyCall") ## Re-building PyCall
using EasyPlotting; EasyPlotting.easymain() ## Run EasyPlotting.jl

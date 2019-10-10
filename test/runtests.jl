## Test successful precompilation of EasyPlotting and loading of EasyPlotting functions
using EasyPlotting, Test
@test_nowarn EasyPlotting.easymain()
@test_nowarn EasyPlotting.easybarchart()
@test_nowarn EasyPlotting.easyboxandwhisker()
@test_nowarn EasyPlotting.easyheatmap()
@test_nowarn EasyPlotting.easyhistogram()
@test_nowarn EasyPlotting.easylinegraph()
@test_nowarn EasyPlotting.easypiechart()
@test_nowarn EasyPlotting.easyscatterplot2d()
@test_nowarn EasyPlotting.easyscatterplot3d()
@test_nowarn EasyPlotting.easystripplot()
@test_nowarn EasyPlotting.easyviolinplot()

## Test successfull installation of python3's seaborn package using Conda.jl
ENV["PYTHON"]="" ## Reset python3 PATH to set Julia-specific python3 version maintained by Conda.jl
using Pkg; Pkg.build("PyCall") ## Re-build PyCall

## Use packages specific for additional testing
using Blink, Interact, Seaborn, Conda
Conda.add("seaborn") ## Test adding python3's seaborn package via Conda.jl

## Include src scripts for testing
include("../src/easymain.jl")
include("../src/easybarchart.jl")
include("../src/easyboxandwhisker.jl")
include("../src/easyheatmap.jl")
include("../src/easyhistogram.jl")
include("../src/easylinegraph.jl")
include("../src/easypiechart.jl")
include("../src/easyscatterplot2d.jl")
include("../src/easyscatterplot3d.jl")
include("../src/easystripplot.jl")
include("../src/easyviolinplot.jl")

## Invoke functions associated with respective src scripts for testing
@test_nowarn easymain()
@test_nowarn easybarchart()
@test_nowarn easyboxandwhisker()
@test_nowarn easyheatmap()
@test_nowarn easyhistogram()
@test_nowarn easylinegraph()
@test_nowarn easypiechart()
@test_nowarn easyscatterplot2d()
@test_nowarn easyscatterplot3d()
@test_nowarn easystripplot()
@test_nowarn easyviolinplot()

## Test successful plotting with Julia's Seaborn built using python3's seaborn installed via Conda.jl
@test_nowarn Seaborn.plot(rand(5,5))

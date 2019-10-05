## Test successfull installation of python3's seaborn package using Conda.jl
ENV["PYTHON"]="" ## Reset python3 PATH to set Julia-specific python3 version maintained by Conda.jl
using Pkg; Pkg.build("PyCall") ## Re-build PyCall

using Blink, Interact, Seaborn, Conda, Test ## Use packages specific for testing

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

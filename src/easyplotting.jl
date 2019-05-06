module easyplotting ## Define easyplotting module

#include(joinpath(pathof(easyplotting)[1:end-12], "easyheatmap.jl")) ## Include easyheatmap.jl script for function easyheatmap()
cd(joinpath(pathof(easyplotting)[1:end-15]) && include("easyheatmap.jl")

end #module

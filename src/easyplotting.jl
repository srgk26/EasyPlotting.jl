module easyplotting ## Define easyplotting module

cd(pathof(easyplotting)[1:end-15]) ## Changing to easyplotting src folder for executing other src scripts as necessary

include("init.jl") ## Include init.jl for function init()
include("easyheatmap.jl") ## Include easyheatmap.jl script for function easyheatmap()

end #module

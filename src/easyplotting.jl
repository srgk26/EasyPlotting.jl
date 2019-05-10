module easyplotting ## Define easyplotting module

cd(pathof(easyplotting)[1:end-15]) ## Changing to easyplotting src folder for executing other src scripts as necessary

include("easyheatmap.jl") ## Include easyheatmap.jl script for function easyheatmap()
include("extrainstall/extrainstall.jl") ## Include extrainstall.jl for function extrainstall()

end #module

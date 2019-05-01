## This script should be executed from within the Julia REPL.
## For some reason, blink window doesn't function properly if executed from command line $ julia ./easy_plotting.jl
## Instead, $ julia
##          julia> include("easy_plotting.jl")

using Blink, Interact, DelimitedFiles, CSV, XLSX, DataFrames, Seaborn
w = Window() ## Opening Blink window

## Defining input widgets for data selection
function page_inputs()
    file = filepicker(accept=[".csv", ".txt", ".xlsx"]) ## Restricting file input types
    sheet = textbox("sheet name")
    clustering = dropdown(["row", "column", "both", "none"])
    size1 = textbox("Default: x-axis = 6")
    size2 = textbox("Default: y-axis = 7")
    colours = dropdown(["Default", "Blues", "Reds", "Purples", "Greens", "mako", "BuGn_r", "cubehelix", "BrBG", "RdBu_r", "coolwarm"])
    enter_button = button("Plot")
    Widget(["file"=>file, "sheet"=>sheet, "clustering"=>clustering, "size1"=>size1, "size2"=>size2, "colours"=>colours, "enter_button"=>enter_button])
end
inputs = page_inputs()

## Designing page layout
page = node(:div,
            node(:p, "Upload data file below - only .txt/.csv/.xlsx file extensions accepted:", style=Dict(:color=>"blue", :size=>"80", :padding=>"5px")),
            node(:div, inputs["file"]),
            node(:div),
            node(:p, hbox(pad(0.5em, "If .xlsx file, pls also enter sheet name (case & space sensitive):"), pad(0.25em, inputs["sheet"])), style=Dict(:color=>"red", :size=>"40", :padding=>"5px")),
            node(:p, hbox(pad(0.5em, "Choose options for dendrogram clustering:"), pad(0.25em, inputs["clustering"])), style=Dict(:color=>"blue", :size=>"40", :padding=>"5px")),
            node(:p, hbox(pad(0.5em, "(Optional) Enter plot size (numbers only):"), pad(0.25em, inputs["size1"]), pad(0.25em, inputs["size2"])), style=Dict(:color=>"green", :size=>"40", :padding=>"5px")),
            node(:p, hbox(pad(0.5em, "(Optional) Select fill colour palette for heatmap:"), pad(0.25em, inputs["colours"])), style=Dict(:color=>"blue", :size=>"40", :padding=>"5px")),
            node(:p, inputs["enter_button"]))

body!(w, page) ## Adding page layout options to Blink window 'w'
Blink.title(w, "Heatmap") ## Adding title to Blink window 'w'

## Defining function -- plotting instructions -- to be called from within Plot(w, inputs) function
function Fig()
    tmpdir = mktempdir()
    fig = joinpath(tmpdir, "tmp_heatmap.png")
    savefig(fig)
    run(`open $fig`)
end

## Main function code to plot heatmap, using user-defined input options
function Plot(w, inputs)
    if inputs["enter_button"][] == 0 ## Setting while loop criteria that allows process running continuously until true is returned
        return false
    elseif inputs["enter_button"][] > 0 ## Initiates processes when "enter_button" is pressed
        if (inputs["file"][]::String)[end-3:end] == "xlsx" ## If input file is .xlsx
            df = DataFrame(XLSX.readtable((inputs["file"][]::String), (inputs["sheet"][]::String))...) ## Convert dataset to dataframe
            if inputs["clustering"][] == "both" ## For row+column clustering option
                if inputs["size1"][]::String == "" ## If no user-input for plot size
                    if inputs["colours"][] == "Default" ## If no user-input for plot colours
                        clustermap(convert(Matrix, df), row_cluster=true, col_cluster=true, figsize=(6,7)) ## Seaborn Clustermap plotting
                        Fig() ## Call Fig() function defined above
                        return true ## Returns true value, thereby stopping while loop that keeps the process running
                    else ## If plot colours is defined by user
                        clustermap(convert(Matrix, df), row_cluster=true, col_cluster=true, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else ## If plot size is defined by user
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), row_cluster=true, col_cluster=true, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), row_cluster=true, col_cluster=true, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "row" ## For row clustering option
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), row_cluster=true, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), row_cluster=true, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), row_cluster=true, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), row_cluster=true, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "column" ## For column clustering option
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), col_cluster=true, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), col_cluster=true, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), col_cluster=true, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), col_cluster=true, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            else ## For no clustering option
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            end
        elseif (inputs["file"][]::String)[end-2:end] == "csv" ## If input file is .csv
            df = DataFrame(CSV.read(inputs["file"][]::String))
            if inputs["clustering"][] == "both"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), row_cluster=true, col_cluster=true, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), row_cluster=true, col_cluster=true, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), row_cluster=true, col_cluster=true, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), row_cluster=true, col_cluster=true, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "row"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), row_cluster=true, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), row_cluster=true, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), row_cluster=true, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), row_cluster=true, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "column"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), col_cluster=true, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), col_cluster=true, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), col_cluster=true, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), col_cluster=true, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            else
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            end
        elseif (inputs["file"][]::String)[end-2:end] == "txt" ## If input file is .txt
            df = DataFrame(readdlm(inputs["file"][]::String))
            if inputs["clustering"][] == "both"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), row_cluster=true, col_cluster=true, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), row_cluster=true, col_cluster=true, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), row_cluster=true, col_cluster=true, (parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), row_cluster=true, col_cluster=true, (parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "row"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), row_cluster=true, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), row_cluster=true, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), row_cluster=true, (parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), row_cluster=true, (parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "column"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), col_cluster=true, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), col_cluster=true, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), col_cluster=true, (parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), col_cluster=true, (parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            else
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df), (parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df), (parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            end
        end
    end
end

## Defining function that keeps the function Plot(w, input) running until true boolean value is returned
function events(w, inputs)
    @async while true ## Syncing all processes above
        Plot(w, inputs) == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
    end
end

events(w, inputs)

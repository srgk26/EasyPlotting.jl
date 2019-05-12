#### Main code for heatmap plotting GUI
using Blink, Interact, DelimitedFiles, CSV, XLSX, DataFrames, Seaborn, Conda ## Importing required libraries
function easyheatmap() ## Defining function to be called by user
    w = Blink.Window() ## Opening Blink window

    ## Defining input widgets for data selection
    function page_inputs()
        file = Interact.filepicker(accept=[".csv", ".txt", ".xlsx"]) ## Restricting file input types
        sheet = Interact.textbox("sheet name")
        clustering = Interact.dropdown(["row", "column", "both", "none"])
        size1 = Interact.textbox("Default: x-axis = 6")
        size2 = Interact.textbox("Default: y-axis = 7")
        colours = Interact.dropdown(["Default", "Blues", "Reds", "Purples", "Greens", "mako", "BuGn_r", "cubehelix", "BrBG", "RdBu_r", "coolwarm"])
        enter_button = html"""<button onclick='Blink.msg("press", "foo")'>Plot</button>"""  ## Using HTML format since action-on-click works with this
        Interact.Widget(["file"=>file, "sheet"=>sheet, "clustering"=>clustering, "size1"=>size1, "size2"=>size2, "colours"=>colours, "enter_button"=>enter_button])
    end
    inputs = page_inputs()

    ## Designing page layout
    page = Interact.node(:div,
                Interact.node(:p, "Upload data file below - only .txt/.csv/.xlsx file extensions accepted:", style=Dict(:color=>"blue", :size=>"80", :padding=>"5px")),
                Interact.node(:div, inputs["file"]),
                Interact.node(:div),
                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "If .xlsx file, pls also enter sheet name (case & space sensitive):"), Interact.pad(0.25, inputs["sheet"])), style=Dict(:color=>"red", :size=>"40", :padding=>"5px")),
                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "Choose options for dendrogram clustering:"), Interact.pad(0.25, inputs["clustering"])), style=Dict(:color=>"blue", :size=>"40", :padding=>"5px")),
                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Enter plot size (numbers only):"), Interact.pad(0.25, inputs["size1"]), Interact.pad(0.25, inputs["size2"])), style=Dict(:color=>"green", :size=>"40", :padding=>"5px")),
                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for heatmap:"), Interact.pad(0.25, inputs["colours"])), style=Dict(:color=>"blue", :size=>"40", :padding=>"5px")),
                Interact.node(:p, inputs["enter_button"]))

    Blink.body!(w, page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Heatmap") ## Adding title to Blink window 'w'

    ## Defining function -- plotting instructions -- to be called from within Plot(w, inputs) function
    function Fig()
        tmpdir = mktempdir()
        fig = joinpath(tmpdir, "tmp_heatmap.png")
        savefig(fig)
        run(`open $fig`)
    end

    ## Main function code to plot heatmap, using user-defined input options
    function Plot()
        if (inputs["file"][]::String)[end-3:end] == "xlsx" ## If input file is .xlsx
            df = DataFrames.DataFrame(XLSX.readtable((inputs["file"][]::String), (inputs["sheet"][]::String))...) ## Convert dataset to dataframe
            if inputs["clustering"][] == "both" ## For row+column clustering option
                if inputs["size1"][]::String == "" ## If no user-input for plot size
                    if inputs["colours"][] == "Default" ## If no user-input for plot colours
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(6,7)) ## Seaborn Clustermap plotting
                        Fig() ## Call Fig() function defined above
                        return true ## Returns true value, thereby stopping while loop that keeps the process running
                    else ## If plot colours is defined by user
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else ## If plot size is defined by user
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "row" ## For row clustering option
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "column" ## For column clustering option
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            else ## For no clustering option
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            end
        elseif (inputs["file"][]::String)[end-2:end] == "csv" ## If input file is .csv
            df = DataFrames.DataFrame(CSV.read(inputs["file"][]::String))
            if inputs["clustering"][] == "both"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(6,7))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "row"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "column"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            else
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            end
        elseif (inputs["file"][]::String)[end-2:end] == "txt" ## If input file is .txt
            df = DataFrames.DataFrame(DelimitedFiles.readdlm(inputs["file"][]::String, '\t'))
            if inputs["clustering"][] == "both"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), figsize=(6,7))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "row"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), col_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), col_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), col_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), col_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "column"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            else
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, col_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, col_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, inputs["size1"][]), parse(Float64, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            end
        end
    end

    ## Defining function that keeps the function Plot(w, input) running until true boolean value is returned
    function events()
        @async while true ## Syncing all processes above
            Plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "press") do args...  ## When enter_button is pressed, the following arguments are executed
      events()  ## When enter_button is pressed, events(w, inputs) is executed.
    end
end

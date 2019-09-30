#### Main code for heatmap plot
function easyheatmap()
    w = Blink.Window() ## Opening new Blink Window

    ## Defining easyheatmap_input widgets for user inputs
    function easyheatmap_inputs()
        easyheatmap_file = Interact.filepicker(accept=[".xlsx", ".csv", ".txt"]) ## Restricting file input types to .xlsx/.csv/.txt
        easyheatmap_sheet = Interact.textbox("Excel sheet name") ## Need sheet name for .xlsx files
        easyheatmap_dataformat_button = html"""<button onclick='Blink.msg("easyheatmap_dataformat", "foo")'>Dataset format</button>""" ## Click to view dataset format
        easyheatmap_clustering = Interact.dropdown(["row", "column", "both", "none"]) ## Choose heatmap clustering options
        easyheatmap_size1 = Interact.textbox("Default: x-axis = 6") ## Choose x-axis figure size
        easyheatmap_size2 = Interact.textbox("Default: y-axis = 7") ## Choose y-axis figure size
        easyheatmap_colours = Interact.dropdown(["Default", "Blues", "Reds", "Purples", "Greens", "mako", "BuGn_r", "cubehelix", "BrBG", "RdBu_r", "coolwarm"]) ## Choose heatmap colours
        easyheatmap_scale = Interact.dropdown(["None", "loge", "log2", "log10"]) ## Choose logarithmic scaling options
        easyheatmap_back_button = html"""<button onclick='Blink.msg("easyheatmap_back", "foo")'>Go back</button>""" ## Go-back button
        easyheatmap_plot_button = html"""<button onclick='Blink.msg("easyheatmap_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easyheatmap_file"=>easyheatmap_file, "easyheatmap_sheet"=>easyheatmap_sheet, "easyheatmap_dataformat_button"=>easyheatmap_dataformat_button, "easyheatmap_clustering"=>easyheatmap_clustering, "easyheatmap_size1"=>easyheatmap_size1, "easyheatmap_size2"=>easyheatmap_size2, "easyheatmap_colours"=>easyheatmap_colours, "easyheatmap_scale"=>easyheatmap_scale, "easyheatmap_back_button"=>easyheatmap_back_button, "easyheatmap_plot_button"=>easyheatmap_plot_button]) ## Consolidating all widgets
    end
    easyheatmap_inputsFn = easyheatmap_inputs()

    easyheatmap_intro1 = "This section provides additional 'Heatmap' specific configuration options that you could select below to further customise your heatmap. Kindly also take note that the linkage method used for clustering is 'average' and the metric is 'euclidean'. If you would like other custom metrics, kindly open an issue and I will include them in."
    easyheatmap_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easyheatmap_intro3 = "Now please upload your dataset below and select options for heatmap:"

    ## Designing easyheatmap_page layout
    easyheatmap_page = Interact.node(:html,
                            style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                            Interact.node(:p, easyheatmap_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, easyheatmap_intro2), Interact.pad(0.25, easyheatmap_inputsFn["easyheatmap_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, easyheatmap_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "Upload data file - only .txt/.csv/.xlsx file extensions accepted:"), Interact.pad(0.25, easyheatmap_inputsFn["easyheatmap_file"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "If excel .xlsx file, pls also enter sheet name (case & space sensitive):"), Interact.pad(0.25, easyheatmap_inputsFn["easyheatmap_sheet"])), style=Dict(:color=>"#F4A460", :size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "Choose options for dendrogram clustering:"), Interact.pad(0.25, easyheatmap_inputsFn["easyheatmap_clustering"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Enter plot size (numbers only):"), Interact.pad(0.25, easyheatmap_inputsFn["easyheatmap_size1"]), Interact.pad(0.25, easyheatmap_inputsFn["easyheatmap_size2"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for heatmap:"), Interact.pad(0.25, easyheatmap_inputsFn["easyheatmap_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easyheatmap_inputsFn["easyheatmap_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.25, easyheatmap_inputsFn["easyheatmap_back_button"]), Interact.pad(0.25, easyheatmap_inputsFn["easyheatmap_plot_button"])), style=Dict(:position => "absolute", :left => "650px")))

    Blink.body!(w, easyheatmap_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Heatmap") ## Adding title to Blink window 'w'

    ## Defining function to save heatmap plot
    function easyheatmap_fig()
        tmp_heatmap = joinpath(mktempdir(), "tmp_heatmap.png") ## Assign temporary filename for heatmap produced
        Seaborn.savefig(tmp_heatmap) ## Saves heatmap figure
        run(`open $tmp_heatmap`) ## Open temporary heatmap figure file
    end

    ## Main function code to plot heatmap, using user-defined input options
    function easyheatmap_plot()
        if easyheatmap_inputsFn["easyheatmap_scale"][] == "None" ## For no logarithmic scaling
            if easyheatmap_inputsFn["easyheatmap_clustering"][] == "both" ## For row+column clustering option
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == "" ## If no user-input for plot size
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default" ## If no user-input for plot colours
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(6,7)) ## Seaborn Clustermap plotting
                        easyheatmap_fig() ## Call easyheatmap_fig() function defined above
                        return true ## Returns true value, thereby stopping while loop that keeps the process running
                    else ## If plot colours is defined by user
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else ## If plot size is defined by user
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            elseif easyheatmap_inputsFn["easyheatmap_clustering"][] == "row" ## For row clustering option
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            elseif easyheatmap_inputsFn["easyheatmap_clustering"][] == "column" ## For column clustering option
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            else ## For no clustering option
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            end
        elseif easyheatmap_inputsFn["easyheatmap_scale"][] == "loge" ## For loge logarithmic scaling
            if easyheatmap_inputsFn["easyheatmap_clustering"][] == "both"
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            elseif easyheatmap_inputsFn["easyheatmap_clustering"][] == "row"
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            elseif easyheatmap_inputsFn["easyheatmap_clustering"][] == "column"
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            else
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            end
        elseif easyheatmap_inputsFn["easyheatmap_scale"][] == "log2" ## For log2 logarithmic scaling
            if easyheatmap_inputsFn["easyheatmap_clustering"][] == "both"
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            elseif easyheatmap_inputsFn["easyheatmap_clustering"][] == "row"
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            elseif easyheatmap_inputsFn["easyheatmap_clustering"][] == "column"
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            else
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log2.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            end
        elseif easyheatmap_inputsFn["easyheatmap_scale"][] == "log10" ## For log10 logarithmic scaling
            if easyheatmap_inputsFn["easyheatmap_clustering"][] == "both"
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            elseif easyheatmap_inputsFn["easyheatmap_clustering"][] == "row"
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            elseif easyheatmap_inputsFn["easyheatmap_clustering"][] == "column"
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            else
                if easyheatmap_inputsFn["easyheatmap_size1"][]::String == ""
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                else
                    if easyheatmap_inputsFn["easyheatmap_colours"][] == "Default"
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])))
                        easyheatmap_fig()
                        return true
                    else
                        Seaborn.clustermap(log10.(convert(Matrix, df[:,2:end])), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, easyheatmap_inputsFn["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputsFn["easyheatmap_size2"][])), cmap=(easyheatmap_inputsFn["easyheatmap_colours"][]))
                        easyheatmap_fig()
                        return true
                    end
                end
            end
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easyheatmap_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(EasyPlotting)[1:end-19], "Figures/Heatmap/heatmap_dataformat.png"))) ## When easyheatmap_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easyheatmap_back") do args...
        easymain() ## When easyheatmap_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easyheatmap_plot") do args... ## When easyheatmap_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            if (easyheatmap_inputsFn["easyheatmap_file"][]::String)[end-3:end] == "xlsx" ## If input file is .xlsx
                global df = DataFrames.DataFrame(XLSX.readtable((easyheatmap_inputsFn["easyheatmap_file"][]::String), (easyheatmap_inputsFn["easyheatmap_sheet"][]::String))...) ## Convert dataset to dataframe
            elseif (easyheatmap_inputsFn["easyheatmap_file"][]::String)[end-2:end] == "csv" ## If input file is .csv
                global df = DataFrames.DataFrame(CSV.read(easyheatmap_inputsFn["easyheatmap_file"][]::String)) ## Convert dataset to dataframe
            elseif (easyheatmap_inputsFn["easyheatmap_file"][]::String)[end-2:end] == "txt" ## If input file is .txt
                global df = DataFrames.DataFrame(DelimitedFiles.readdlm(easyheatmap_inputsFn["easyheatmap_file"][]::String, '\t')) ## Convert dataset to dataframe

                ## Renaming row 1 of df as column names since .txt files return the top row as row 1 instead of column names
                for i in 1:size(df, 2)
                    DataFrames.rename!(df, names(df)[i]=>Symbol(df[1,i]))
                end
                DataFrames.deleterows!(df, 1) ## Deleting row 1 of df
            end

            ## Plot heatmap
            easyheatmap_events() ## When easyheatmap_plot_button is pressed, easyheatmap_events() is executed.
        catch
            ## Alert if sheet name is not entered for excel .xlsx files
            if (easyheatmap_inputsFn["easyheatmap_file"][]::String)[end-3:end] == "xlsx" && easyheatmap_inputsFn["easyheatmap_sheet"][]::String == ""
                @js_ w alert("Excel .xlsx sheet name not entered. Kindly enter the sheet name and try again.")
            else
                @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
            end
        end
    end

    ## Defining function that keeps the function easyheatmap_plot() running until true boolean value is returned
    function easyheatmap_events()
        @async while true ## Syncing all processes above
            easyheatmap_plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end
end #function easyheatmap()

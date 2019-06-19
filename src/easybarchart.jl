#### Main code for barchart plot
function easybarchart()
    ## Defining easybarchart_input widgets for user inputs
    function easybarchart_inputs()
        easybarchart_dataformat_button = html"""<button onclick='Blink.msg("easybarchart_dataformat", "foo")'>Dataset format</button>""" ## Click to view dataset format
        easybarchart_colours = Interact.dropdown(["algae", "amp", "balance", "bgy", "bgyw", "bjy", "bkr", "bky", "blues", "bluesreds", "bmw", "colorwheel", "coolwarm", "dimgray", "fire", "curl", "dark_grad", "darkrainbow", "darktest",
                                                    "deep", "delta", "dense", "gray", "grays", "greens", "gwv", "haline", "heat", "ice", "inferno", "isolum", "juno_grad", "kb", "kdc", "kg", "kgy", "kr", "lightrainbow", "lighttest",
                                                    "lime_grad", "magma", "matter", "orange_grad", "oxy", "phase", "plasma", "pu_or", "rainbow", "reds", "redsblues", "sand_grad", "solarized_grad", "solarized_light_grad", "solar", "speed",
                                                    "tempo", "thermal", "turbid", "viridis", "Blues", "BrBG", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "OrRd", "Oranges", "PRGn", "PiYG", "PuBu", "PuBuGn", "PuOr", "PuRd", "Purples",
                                                    "RdBu", "RdGy", "RdPu", "RdYlBu", "RdYlGn", "Reds", "Spectral", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd"]) ## Choose barchart colours
        easybarchart_back_button = html"""<button onclick='Blink.msg("easybarchart_back", "foo")'>Go back</button>""" ## Go-back button
        easybarchart_plot_button = html"""<button onclick='Blink.msg("easybarchart_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easybarchart_dataformat_button"=>easybarchart_dataformat_button, "easybarchart_colours"=>easybarchart_colours, "easybarchart_back_button"=>easybarchart_back_button, "easybarchart_plot_button"=>easybarchart_plot_button]) ## Consolidating all widgets
    end

    easybarchart_intro1 = "This section provides additional 'Bar Chart' specific configuration options that you could select below to further customise your barchart."
    easybarchart_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easybarchart_intro3 = "Now please select options for heatmap:"

    ## Designing easybarchart_page layout
    easybarchart_page = Interact.node(:html,
                            style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                            Interact.node(:p, easyheatmap_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, easyheatmap_intro2), Interact.pad(0.25, easyheatmap_inputs()["easyheatmap_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, easyheatmap_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "Choose options for dendrogram clustering:"), Interact.pad(0.25, easyheatmap_inputs()["easyheatmap_clustering"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Enter plot size (numbers only):"), Interact.pad(0.25, easyheatmap_inputs()["easyheatmap_size1"]), Interact.pad(0.25, easyheatmap_inputs()["easyheatmap_size2"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for heatmap:"), Interact.pad(0.25, easyheatmap_inputs()["easyheatmap_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, easyheatmap_inputs()["easyheatmap_back_button"], style=Dict(:position => "absolute", :left => "650px")),
                            Interact.node(:p, easyheatmap_inputs()["easyheatmap_plot_button"], style=Dict(:position => "absolute", :left => "720px")))

    Blink.body!(w, easyheatmap_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Heatmap") ## Adding title to Blink window 'w'

    ## Defining function to save heatmap plot
    function easyheatmap_fig()
        tmp_heatmap = joinpath(mktempdir(), "tmp_heatmap.png") ## Assign temporary filename for heatmap produced
        savefig(tmp_heatmap) ## Saves heatmap figure
        run(`open $tmp_heatmap`) ## Open temporary heatmap figure file
    end

    ## Main function code to plot heatmap, using user-defined input options
    function easyheatmap_plot()
        if easyheatmap_inputs()["easyheatmap_clustering"][] == "both" ## For row+column clustering option
            if easyheatmap_inputs()["easyheatmap_size1"][]::String == "" ## If no user-input for plot size
                if easyheatmap_inputs()["easyheatmap_colours"][] == "Default" ## If no user-input for plot colours
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(6,7)) ## Seaborn Clustermap plotting
                    easyheatmap_fig() ## Call easyheatmap_fig() function defined above
                    return true ## Returns true value, thereby stopping while loop that keeps the process running
                else ## If plot colours is defined by user
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(6,7), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            else ## If plot size is defined by user
                if easyheatmap_inputs()["easyheatmap_colours"][] == "Default"
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])))
                    easyheatmap_fig()
                    return true
                else
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            end
        elseif easyheatmap_inputs()["easyheatmap_clustering"][] == "row" ## For row clustering option
            if easyheatmap_inputs()["easyheatmap_size1"][]::String == ""
                if easyheatmap_inputs()["easyheatmap_colours"][] == "Default"
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(6,7))
                    easyheatmap_fig()
                    return true
                else
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            else
                if easyheatmap_inputs()["easyheatmap_colours"][] == "Default"
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])))
                    easyheatmap_fig()
                    return true
                else
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", col_cluster=false, figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            end
        elseif easyheatmap_inputs()["easyheatmap_clustering"][] == "column" ## For column clustering option
            if easyheatmap_inputs()["easyheatmap_size1"][]::String == ""
                if inputs["easyheatmap_colours"][] == "Default"
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(6,7))
                    easyheatmap_fig()
                    return true
                else
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            else
                if easyheatmap_inputs()["easyheatmap_colours"][] == "Default"
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])))
                    easyheatmap_fig()
                    return true
                else
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), method="average", metric="euclidean", row_cluster=false, figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            end
        else ## For no clustering option
            if easyheatmap_inputs()["easyheatmap_size1"][]::String == ""
                if easyheatmap_inputs()["easyheatmap_colours"][] == "Default"
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7))
                    easyheatmap_fig()
                    return true
                else
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            else
                if easyheatmap_inputs()["easyheatmap_colours"][] == "Default"
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])))
                    easyheatmap_fig()
                    return true
                else
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            end
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easyheatmap_dataformat") do args... ## When easyheatmap_dataformat_button is pressed, the following arguments are executed
        ImageView.imshow(FileIO.load(joinpath(pathof(easyplotting)[1:end-19], "Figures/Heatmap/heatmap_dataformat.png"))) ## When easyheatmap_dataformat_button is pressed, picture of user input data format pops out..
    end

    Blink.handle(w, "easyheatmap_back") do args... ## When easyheatmap_back_button is pressed, the following arguments are executed
        easymain() ## When easyheatmap_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easyheatmap_plot") do args... ## When easyheatmap_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            easyheatmap_events() ## When easyheatmap_plot_button is pressed, easyheatmap_events() is executed.
        catch
            @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
        end
    end

    ## Defining function that keeps the function easyheatmap_plot() running until true boolean value is returned
    function easyheatmap_events()
        @async while true ## Syncing all processes above
            Plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end
end #function easyheatmap()

#### Main code for heatmap plot
function easyheatmap()
    ## Defining easyheatmap_input widgets for user inputs
    function easyheatmap_inputs()
        easyheatmap_dataformat_button = html"""<button onclick='Blink.msg("easyheatmap_dataformat", "foo")'>Dataset format</button>""" ## Click to view dataset format
        easyheatmap_clustering = Interact.dropdown(["row", "column", "both", "none"]) ## Choose heatmap clustering options
        easyheatmap_size1 = Interact.textbox("Default: x-axis = 6") ## Choose x-axis figure size
        easyheatmap_size2 = Interact.textbox("Default: y-axis = 7") ## Choose y-axis figure size
        easyheatmap_colours = Interact.dropdown(["Default", "Blues", "Reds", "Purples", "Greens", "mako", "BuGn_r", "cubehelix", "BrBG", "RdBu_r", "coolwarm"]) ## Choose heatmap colours
        easyheatmap_back_button = html"""<button onclick='Blink.msg("easyheatmap_back", "foo")'>Go back</button>""" ## Go-back button
        easyheatmap_plot_button = html"""<button onclick='Blink.msg("easyheatmap_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easyheatmap_dataformat_button"=>easyheatmap_dataformat_button, "easyheatmap_clustering"=>easyheatmap_clustering, "easyheatmap_size1"=>easyheatmap_size1, "easyheatmap_size2"=>easyheatmap_size2, "easyheatmap_colours"=>easyheatmap_colours, "easyheatmap_back_button"=>easyheatmap_back_button, "easyheatmap_plot_button"=>easyheatmap_plot_button]) ## Consolidating all widgets
    end

    easyheatmap_intro1 = "This section provides additional 'Heatmap' specific configuration options that you could select below tor further customise your heatmap."
    easyheatmap_intro2 = "But first, your input dataset must be of the correct format. Click here for more:"
    easyheatmap_intro3 = "Now please select options for heatmap:"

    ## Designing easyheatmap_page layout
    easyheatmap_page = Interact.node(:html,
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
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(6,7)) ## Seaborn Clustermap plotting
                    easyheatmap_fig() ## Call easyheatmap_fig() function defined above
                    return true ## Returns true value, thereby stopping while loop that keeps the process running
                else ## If plot colours is defined by user
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(6,7), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            else ## If plot size is defined by user
                if easyheatmap_inputs()["easyheatmap_colours"][] == "Default"
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])))
                    easyheatmap_fig()
                    return true
                else
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            end
        elseif easyheatmap_inputs()["easyheatmap_clustering"][] == "row" ## For row clustering option
            if easyheatmap_inputs()["easyheatmap_size1"][]::String == ""
                if easyheatmap_inputs()["easyheatmap_colours"][] == "Default"
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(6,7))
                    easyheatmap_fig()
                    return true
                else
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            else
                if easyheatmap_inputs()["easyheatmap_colours"][] == "Default"
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])))
                    easyheatmap_fig()
                    return true
                else
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            end
        elseif easyheatmap_inputs()["easyheatmap_clustering"][] == "column" ## For column clustering option
            if easyheatmap_inputs()["easyheatmap_size1"][]::String == ""
                if inputs["easyheatmap_colours"][] == "Default"
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(6,7))
                    easyheatmap_fig()
                    return true
                else
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(6,7), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
                    easyheatmap_fig()
                    return true
                end
            else
                if easyheatmap_inputs()["easyheatmap_colours"][] == "Default"
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])))
                    easyheatmap_fig()
                    return true
                else
                    Seaborn.clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(parse(Float64, easyheatmap_inputs()["easyheatmap_size1"][]), parse(Float64, easyheatmap_inputs()["easyheatmap_size2"][])), cmap=(easyheatmap_inputs()["easyheatmap_colours"][]::String))
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

    ## Defining function that keeps the function easyheatmap_plot() running until true boolean value is returned
    function easyheatmap_events()
        @async while true ## Syncing all processes above
            Plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easyheatmap_dataformat") do args... ## When easyheatmap_dataformat_button is pressed, the following arguments are executed
        ImageView.imshow(FileIO.load(joinpath(pathof(easyplotting)[1:end-15], "Heatmap/Heatmap_dataformat.png"))) ## When easyheatmap_dataformat_button is pressed, picture of user input data format pops out..
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
end #function easyheatmap()
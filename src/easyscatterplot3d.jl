#### Main code for scatterplot3d plot
function easyscatterplot3d()
    ## Defining easyscatterplot3d_input widgets for user inputs
    function easyscatterplot3d_inputs()
        easyscatterplot3d_dataformat_button = html"""<button onclick='Blink.msg("easyscatterplot3d_dataformat", "foo")'>Dataset format</button>""" ## Click to view dataset format
        easyscatterplot3d_colours = Interact.dropdown(["algae", "amp", "balance", "bgy", "bgyw", "bjy", "bkr", "bky", "blues", "bluesreds", "bmw", "colorwheel", "coolwarm", "dimgray", "fire", "curl", "dark_grad", "darkrainbow", "darktest",
                                                    "deep", "delta", "dense", "gray", "grays", "greens", "gwv", "haline", "heat", "ice", "inferno", "isolum", "juno_grad", "kb", "kdc", "kg", "kgy", "kr", "lightrainbow", "lighttest",
                                                    "lime_grad", "magma", "matter", "orange_grad", "oxy", "phase", "plasma", "pu_or", "rainbow", "reds", "redsblues", "sand_grad", "solarized_grad", "solarized_light_grad", "solar", "speed",
                                                    "tempo", "thermal", "turbid", "viridis", "Blues", "BrBG", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "OrRd", "Oranges", "PRGn", "PiYG", "PuBu", "PuBuGn", "PuOr", "PuRd", "Purples",
                                                    "RdBu", "RdGy", "RdPu", "RdYlBu", "RdYlGn", "Reds", "Spectral", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd"]) ## Choose scatterplot3d colours
        easyscatterplot3d_scale = Interact.dropdown(["None", "loge", "log2", "log10"]) ## Choose logarithmic scaling options
        easyscatterplot3d_back_button = html"""<button onclick='Blink.msg("easyscatterplot3d_back", "foo")'>Go back</button>""" ## Go-back button
        easyscatterplot3d_plot_button = html"""<button onclick='Blink.msg("easyscatterplot3d_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easyscatterplot3d_dataformat_button"=>easyscatterplot3d_dataformat_button, "easyscatterplot3d_colours"=>easyscatterplot3d_colours, "easyscatterplot3d_scale"=>easyscatterplot3d_scale, "easyscatterplot3d_back_button"=>easyscatterplot3d_back_button, "easyscatterplot3d_plot_button"=>easyscatterplot3d_plot_button]) ## Consolidating all widgets
    end

    easyscatterplot3d_intro1 = "This section provides additional 'Scatterplot 3D' specific configuration options that you could select below to further customise your Scatterplot 3D."
    easyscatterplot3d_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easyscatterplot3d_intro3 = "Now please select options for Scatterplot 3D:"

    ## Designing easyscatterplot3d_page layout
    easyscatterplot3d_page = Interact.node(:html,
                                style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                                Interact.node(:p, easyscatterplot3d_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, easyscatterplot3d_intro2), Interact.pad(0.25, easyscatterplot3d_inputs()["easyscatterplot3d_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, easyscatterplot3d_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Scatterplot 3D:"), Interact.pad(0.25, easyscatterplot3d_inputs()["easyscatterplot3d_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easyscatterplot3d_inputs()["easyscatterplot3d_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, easyscatterplot3d_inputs()["easyscatterplot3d_back_button"], style=Dict(:position => "absolute", :left => "650px")),
                                Interact.node(:p, easyscatterplot3d_inputs()["easyscatterplot3d_plot_button"], style=Dict(:position => "absolute", :left => "720px")))

    Blink.body!(w, easyscatterplot3d_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Scatterplot 3D") ## Adding title to Blink window 'w'

    ## Main function code to plot scatterplot3d, using user-defined input options
    function easyscatterplot3d_plot()
        if easyscatterplot3d_inputs()["easyscatterplot3d_scale"][] == "None" ## For no logarithmic scaling
            StatsPlots.bar(collect(df[:,2]), collect(df[:,3]), collect(df[:,4]), xlabel = string(names(df)[2]), ylabel = string(names(df)[3]), zlabel = string(names(df)[4]), color=Symbol(easyscatterplot3d_inputs()["easyscatterplot3d_colours"][]::String), legend=false)
            StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
            return true ## Returns true value, thereby stopping while loop that keeps the process running
        elseif easyscatterplot3d_inputs()["easyscatterplot3d_scale"][] == "loge" ## For loge logarithmic scaling
            StatsPlots.bar(log.(collect(df[:,2])), log.(collect(df[:,3])), log.(collect(df[:,4])), xlabel = string(names(df)[2]), ylabel = string(names(df)[3]), zlabel = string(names(df)[4]), color=Symbol(easyscatterplot3d_inputs()["easyscatterplot3d_colours"][]::String), legend=false)
            StatsPlots.gui()
            return true
        elseif easyscatterplot3d_inputs()["easyscatterplot3d_scale"][] == "log2" ## For log2 logarithmic scaling
            StatsPlots.bar(log2.(collect(df[:,2])), log2.(collect(df[:,3])), log2.(collect(df[:,4])), xlabel = string(names(df)[2]), ylabel = string(names(df)[3]), zlabel = string(names(df)[4]), color=Symbol(easyscatterplot3d_inputs()["easyscatterplot3d_colours"][]::String), legend=false)
            StatsPlots.gui()
            return true
        elseif easyscatterplot3d_inputs()["easyscatterplot3d_scale"][] == "log10" ## For log10 logarithmic scaling
            StatsPlots.bar(log10.(collect(df[:,2])), log10.(collect(df[:,3])), log10.(collect(df[:,4])), xlabel = string(names(df)[2]), ylabel = string(names(df)[3]), zlabel = string(names(df)[4]), color=Symbol(easyscatterplot3d_inputs()["easyscatterplot3d_colours"][]::String), legend=false)
            StatsPlots.gui()
            return true
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easyscatterplot3d_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(easyplotting)[1:end-19], "Figures/Scatterplot3d/scatterplot3d_dataformat.png"))) ## When easyscatterplot3d_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easyscatterplot3d_back") do args...
        easymain() ## When easyscatterplot3d_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easyscatterplot3d_plot") do args... ## When easyscatterplot3d_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            easyscatterplot3d_events() ## When easyscatterplot3d_plot_button is pressed, easyscatterplot3d_events() is executed.
        catch
            @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
        end
    end

    ## Defining function that keeps the function easyscatterplot3d_plot() running until true boolean value is returned
    function easyscatterplot3d_events()
        @async while true ## Syncing all processes above
            Plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end
end #function easyscatterplot3d()

#### Main code for piechart plot
function easypiechart()
    ## Defining easypiechart_input widgets for user inputs
    function easypiechart_inputs()
        easypiechart_dataformat_button = html"""<button onclick='Blink.msg("easypiechart_dataformat", "foo")'>Dataset format</button>""" ## Click to view dataset format
        easypiechart_colours = Interact.dropdown(["algae", "amp", "balance", "bgy", "bgyw", "bjy", "bkr", "bky", "blues", "bluesreds", "bmw", "colorwheel", "coolwarm", "dimgray", "fire", "curl", "dark_grad", "darkrainbow", "darktest",
                                                    "deep", "delta", "dense", "gray", "grays", "greens", "gwv", "haline", "heat", "ice", "inferno", "isolum", "juno_grad", "kb", "kdc", "kg", "kgy", "kr", "lightrainbow", "lighttest",
                                                    "lime_grad", "magma", "matter", "orange_grad", "oxy", "phase", "plasma", "pu_or", "rainbow", "reds", "redsblues", "sand_grad", "solarized_grad", "solarized_light_grad", "solar", "speed",
                                                    "tempo", "thermal", "turbid", "viridis", "Blues", "BrBG", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "OrRd", "Oranges", "PRGn", "PiYG", "PuBu", "PuBuGn", "PuOr", "PuRd", "Purples",
                                                    "RdBu", "RdGy", "RdPu", "RdYlBu", "RdYlGn", "Reds", "Spectral", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd"]) ## Choose piechart colours
        easypiechart_scale = Interact.dropdown(["None", "loge", "log2", "log10"])  ## Choose logarithmic scaling options
        easypiechart_back_button = html"""<button onclick='Blink.msg("easypiechart_back", "foo")'>Go back</button>""" ## Go-back button
        easypiechart_plot_button = html"""<button onclick='Blink.msg("easypiechart_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easypiechart_dataformat_button"=>easypiechart_dataformat_button, "easypiechart_colours"=>easypiechart_colours, "easypiechart_scale"=>easypiechart_scale, "easypiechart_back_button"=>easypiechart_back_button, "easypiechart_plot_button"=>easypiechart_plot_button]) ## Consolidating all widgets
    end

    easypiechart_intro1 = "This section provides additional 'Pie Chart' specific configuration options that you could select below to further customise your Pie Chart."
    easypiechart_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easypiechart_intro3 = "Now please select options for Pie Chart:"

    ## Designing easypiechart_page layout
    easypiechart_page = Interact.node(:html,
                                style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                                Interact.node(:p, easypiechart_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, easypiechart_intro2), Interact.pad(0.25, easypiechart_inputs()["easypiechart_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, easypiechart_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Pie Chart:"), Interact.pad(0.25, easypiechart_inputs()["easypiechart_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easypiechart_inputs()["easypiechart_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, easypiechart_inputs()["easypiechart_back_button"], style=Dict(:position => "absolute", :left => "650px")),
                                Interact.node(:p, easypiechart_inputs()["easypiechart_plot_button"], style=Dict(:position => "absolute", :left => "720px")))

    Blink.body!(w, easypiechart_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Pie Chart") ## Adding title to Blink window 'w'

    ## Main function code to plot piechart, using user-defined input options
    function easypiechart_plot()
        if easypiechart_inputs()["easypiechart_scale"][] == "None" ## For no logarithmic scaling
            StatsPlots.boxplot(collect(df[:,1]), collect(df[:,2]), xlabel = string(names(df)[2]), color=Symbol(easypiechart_inputs()["easypiechart_colours"][]::String))
            StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
            return true ## Returns true value, thereby stopping while loop that keeps the process running
        elseif easypiechart_inputs()["easypiechart_scale"][] == "loge" ## For loge logarithmic scaling
            StatsPlots.boxplot(log.(collect(df[:,1])), log.(collect(df[:,2])), xlabel = string(names(df)[2]), color=Symbol(easypiechart_inputs()["easypiechart_colours"][]::String))
            StatsPlots.gui()
            return true
        elseif easypiechart_inputs()["easypiechart_scale"][] == "log2" ## For log2 logarithmic scaling
            StatsPlots.boxplot(log2.(collect(df[:,1])), log2.(collect(df[:,2])), xlabel = string(names(df)[2]), color=Symbol(easypiechart_inputs()["easypiechart_colours"][]::String))
            StatsPlots.gui()
            return true
        elseif easypiechart_inputs()["easypiechart_scale"][] == "log10" ## For log10 logarithmic scaling
            StatsPlots.boxplot(log10.(collect(df[:,1])), log10.(collect(df[:,2])), xlabel = string(names(df)[2]), color=Symbol(easypiechart_inputs()["easypiechart_colours"][]::String))
            StatsPlots.gui()
            return true
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easypiechart_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(easyplotting)[1:end-19], "Figures/Piechart/piechart_dataformat.png"))) ## When easypiechart_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easypiechart_back") do args...
        easymain() ## When easypiechart_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easypiechart_plot") do args... ## When easypiechart_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            easypiechart_events() ## When easypiechart_plot_button is pressed, easypiechart_events() is executed.
        catch
            @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
        end
    end

    ## Defining function that keeps the function easypiechart_plot() running until true boolean value is returned
    function easypiechart_events()
        @async while true ## Syncing all processes above
            Plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end
end #function easypiechart()

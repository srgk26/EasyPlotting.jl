#### Main code for histogram plot
function easyhistogram()
    ## Defining easyhistogram_input widgets for user inputs
    function easyhistogram_inputs()
        easyhistogram_dataformat_button = html"""<button onclick='Blink.msg("easyhistogram_dataformat", "foo")'>Dataset format</button>""" ## Click to view dataset format
        easyhistogram_colours = Interact.dropdown(["algae", "amp", "balance", "bgy", "bgyw", "bjy", "bkr", "bky", "blues", "bluesreds", "bmw", "colorwheel", "coolwarm", "dimgray", "fire", "curl", "dark_grad", "darkrainbow", "darktest",
                                                    "deep", "delta", "dense", "gray", "grays", "greens", "gwv", "haline", "heat", "ice", "inferno", "isolum", "juno_grad", "kb", "kdc", "kg", "kgy", "kr", "lightrainbow", "lighttest",
                                                    "lime_grad", "magma", "matter", "orange_grad", "oxy", "phase", "plasma", "pu_or", "rainbow", "reds", "redsblues", "sand_grad", "solarized_grad", "solarized_light_grad", "solar", "speed",
                                                    "tempo", "thermal", "turbid", "viridis", "Blues", "BrBG", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "OrRd", "Oranges", "PRGn", "PiYG", "PuBu", "PuBuGn", "PuOr", "PuRd", "Purples",
                                                    "RdBu", "RdGy", "RdPu", "RdYlBu", "RdYlGn", "Reds", "Spectral", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd"]) ## Choose histogram colours
        easyhistogram_scale = Interact.dropdown(["None", "loge", "log2", "log10"])  ## Choose logarithmic scaling options
        easyhistogram_back_button = html"""<button onclick='Blink.msg("easyhistogram_back", "foo")'>Go back</button>""" ## Go-back button
        easyhistogram_plot_button = html"""<button onclick='Blink.msg("easyhistogram_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easyhistogram_dataformat_button"=>easyhistogram_dataformat_button, "easyhistogram_colours"=>easyhistogram_colours, "easyhistogram_scale"=>easyhistogram_scale, "easyhistogram_back_button"=>easyhistogram_back_button, "easyhistogram_plot_button"=>easyhistogram_plot_button]) ## Consolidating all widgets
    end

    easyhistogram_intro1 = "This section provides additional 'Histogram' specific configuration options that you could select below to further customise your Histogram."
    easyhistogram_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easyhistogram_intro3 = "Now please select options for Histogram:"

    ## Designing easyhistogram_page layout
    easyhistogram_page = Interact.node(:html,
                            style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                            Interact.node(:p, easyhistogram_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, easyhistogram_intro2), Interact.pad(0.25, easyhistogram_inputs()["easyhistogram_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, easyhistogram_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Histogram:"), Interact.pad(0.25, easyhistogram_inputs()["easyhistogram_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easyhistogram_inputs()["easyhistogram_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, easyhistogram_inputs()["easyhistogram_back_button"], style=Dict(:position => "absolute", :left => "650px")),
                            Interact.node(:p, easyhistogram_inputs()["easyhistogram_plot_button"], style=Dict(:position => "absolute", :left => "720px")))

    Blink.body!(w, easyhistogram_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Histogram") ## Adding title to Blink window 'w'

    ## Main function code to plot histogram, using user-defined input options
    function easyhistogram_plot()
        if easyhistogram_inputs()["easyhistogram_scale"][] == "None" ## For no logarithmic scaling
            StatsPlots.histogram(collect(df[:,2]), xlabel = string(names(df)[2]), color=Symbol(easyhistogram_inputs()["easyhistogram_colours"][]::String), legend=false)
            StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
            return true ## Returns true value, thereby stopping while loop that keeps the process running
        elseif easyhistogram_inputs()["easyhistogram_scale"][] == "loge" ## For loge logarithmic scaling
            StatsPlots.histogram(log.(collect(df[:,2])), xlabel = string(names(df)[2]), color=Symbol(easyhistogram_inputs()["easyhistogram_colours"][]::String), legend=false)
            StatsPlots.gui()
            return true
        elseif easyhistogram_inputs()["easyhistogram_scale"][] == "log2" ## For log2 logarithmic scaling
            StatsPlots.histogram(log2.(collect(df[:,2])), xlabel = string(names(df)[2]), color=Symbol(easyhistogram_inputs()["easyhistogram_colours"][]::String), legend=false)
            StatsPlots.gui()
            return true
        elseif easyhistogram_inputs()["easyhistogram_scale"][] == "log10" ## For log10 logarithmic scaling
            StatsPlots.histogram(log10.(collect(df[:,2])), xlabel = string(names(df)[2]), color=Symbol(easyhistogram_inputs()["easyhistogram_colours"][]::String), legend=false)
            StatsPlots.gui()
            return true
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easyhistogram_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(easyplotting)[1:end-19], "Figures/Histogram/histogram_dataformat.png"))) ## When easyhistogram_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easyhistogram_back") do args...
        easymain() ## When easyhistogram_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easyhistogram_plot") do args... ## When easyhistogram_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            easyhistogram_events() ## When easyhistogram_plot_button is pressed, easyhistogram_events() is executed.
        catch
            @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
        end
    end

    ## Defining function that keeps the function easyhistogram_plot() running until true boolean value is returned
    function easyhistogram_events()
        @async while true ## Syncing all processes above
            Plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end
end #function easyhistogram()

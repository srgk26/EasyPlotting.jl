#### Main code for linegraph plot
function easylinegraph()
    ## Defining easylinegraph_input widgets for user inputs
    function easylinegraph_inputs()
        easylinegraph_dataformat_button = html"""<button onclick='Blink.msg("easylinegraph_dataformat", "foo")'>Dataset format</button>""" ## Click to view dataset format
        easylinegraph_colours = Interact.dropdown(["algae", "amp", "balance", "bgy", "bgyw", "bjy", "bkr", "bky", "blues", "bluesreds", "bmw", "colorwheel", "coolwarm", "dimgray", "fire", "curl", "dark_grad", "darkrainbow", "darktest",
                                                    "deep", "delta", "dense", "gray", "grays", "greens", "gwv", "haline", "heat", "ice", "inferno", "isolum", "juno_grad", "kb", "kdc", "kg", "kgy", "kr", "lightrainbow", "lighttest",
                                                    "lime_grad", "magma", "matter", "orange_grad", "oxy", "phase", "plasma", "pu_or", "rainbow", "reds", "redsblues", "sand_grad", "solarized_grad", "solarized_light_grad", "solar", "speed",
                                                    "tempo", "thermal", "turbid", "viridis", "Blues", "BrBG", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "OrRd", "Oranges", "PRGn", "PiYG", "PuBu", "PuBuGn", "PuOr", "PuRd", "Purples",
                                                    "RdBu", "RdGy", "RdPu", "RdYlBu", "RdYlGn", "Reds", "Spectral", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd"]) ## Choose linegraph colours
        easylinegraph_scale = Interact.dropdown(["None", "loge", "log2", "log10"])  ## Choose logarithmic scaling options
        easylinegraph_size1 = Interact.textbox("Default: x-axis = 600") ## Choose x-axis figure size
        easylinegraph_size2 = Interact.textbox("Default: y-axis = 400") ## Choose y-axis figure size
        easylinegraph_back_button = html"""<button onclick='Blink.msg("easylinegraph_back", "foo")'>Go back</button>""" ## Go-back button
        easylinegraph_plot_button = html"""<button onclick='Blink.msg("easylinegraph_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easylinegraph_dataformat_button"=>easylinegraph_dataformat_button, "easylinegraph_colours"=>easylinegraph_colours, "easylinegraph_scale"=>easylinegraph_scale, "easylinegraph_size1"=>easylinegraph_size1, "easylinegraph_size2"=>easylinegraph_size2, "easylinegraph_back_button"=>easylinegraph_back_button, "easylinegraph_plot_button"=>easylinegraph_plot_button]) ## Consolidating all widgets
    end

    easylinegraph_intro1 = "This section provides additional 'Line graph' specific configuration options that you could select below to further customise your Line graph."
    easylinegraph_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easylinegraph_intro3 = "Now please select options for Line graph:"

    ## Designing easylinegraph_page layout
    easylinegraph_page = Interact.node(:html,
                                style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                                Interact.node(:p, easylinegraph_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, easylinegraph_intro2), Interact.pad(0.25, easylinegraph_inputs()["easylinegraph_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, easylinegraph_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Line graph:"), Interact.pad(0.25, easylinegraph_inputs()["easylinegraph_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easylinegraph_inputs()["easylinegraph_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Enter plot size (numbers only):"), Interact.pad(0.25, easylinegraph_inputs()["easylinegraph_size1"]), Interact.pad(0.25, easylinegraph_inputs()["easylinegraph_size2"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.25, easylinegraph_inputs()["easylinegraph_back_button"]), Interact.pad(0.25, easylinegraph_inputs()["easylinegraph_plot_button"])), style=Dict(:position => "absolute", :left => "650px")))

    Blink.body!(w, easylinegraph_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Line graph") ## Adding title to Blink window 'w'

    ## Main function code to plot linegraph, using user-defined input options
    function easylinegraph_plot()
        if easylinegraph_inputs()["easylinegraph_size1"][]::String == "" ## If no user-input for plot size
            if easylinegraph_inputs()["easylinegraph_scale"][] == "None" ## For no logarithmic scaling
                StatsPlots.plot(convert(Matrix, df[:,2:end]), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputs()["easylinegraph_colours"][]::String), legend=true)
                StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                return true ## Returns true value, thereby stopping while loop that keeps the process running
            elseif easylinegraph_inputs()["easylinegraph_scale"][] == "loge" ## For loge logarithmic scaling
                StatsPlots.plot(log.(convert(Matrix, df[:,2:end])), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputs()["easylinegraph_colours"][]::String), legend=true)
                StatsPlots.gui()
                return true
            elseif easylinegraph_inputs()["easylinegraph_scale"][] == "log2" ## For log2 logarithmic scaling
                StatsPlots.plot(log2.(convert(Matrix, df[:,2:end])), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputs()["easylinegraph_colours"][]::String), legend=true)
                StatsPlots.gui()
                return true
            elseif easylinegraph_inputs()["easylinegraph_scale"][] == "log10" ## For log10 logarithmic scaling
                StatsPlots.plot(log10.(convert(Matrix, df[:,2:end])), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputs()["easylinegraph_colours"][]::String), legend=true)
                StatsPlots.gui()
                return true
            end
        else ## If plot size is defined by user
            if easylinegraph_inputs()["easylinegraph_scale"][] == "None" ## For no logarithmic scaling
                StatsPlots.plot(convert(Matrix, df[:,2:end]), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputs()["easylinegraph_colours"][]::String), size=(parse(Float64, easylinegraph_inputs()["easylinegraph_size1"][]), parse(Float64, easylinegraph_inputs()["easylinegraph_size2"][])), legend=true)
                StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                return true ## Returns true value, thereby stopping while loop that keeps the process running
            elseif easylinegraph_inputs()["easylinegraph_scale"][] == "loge" ## For loge logarithmic scaling
                StatsPlots.plot(log.(convert(Matrix, df[:,2:end])), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputs()["easylinegraph_colours"][]::String), size=(parse(Float64, easylinegraph_inputs()["easylinegraph_size1"][]), parse(Float64, easylinegraph_inputs()["easylinegraph_size2"][])), legend=true)
                StatsPlots.gui()
                return true
            elseif easylinegraph_inputs()["easylinegraph_scale"][] == "log2" ## For log2 logarithmic scaling
                StatsPlots.plot(log2.(convert(Matrix, df[:,2:end])), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputs()["easylinegraph_colours"][]::String), size=(parse(Float64, easylinegraph_inputs()["easylinegraph_size1"][]), parse(Float64, easylinegraph_inputs()["easylinegraph_size2"][])), legend=true)
                StatsPlots.gui()
                return true
            elseif easylinegraph_inputs()["easylinegraph_scale"][] == "log10" ## For log10 logarithmic scaling
                StatsPlots.plot(log10.(convert(Matrix, df[:,2:end])), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputs()["easylinegraph_colours"][]::String), size=(parse(Float64, easylinegraph_inputs()["easylinegraph_size1"][]), parse(Float64, easylinegraph_inputs()["easylinegraph_size2"][])), legend=true)
                StatsPlots.gui()
                return true
            end
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easylinegraph_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(easyplotting)[1:end-19], "Figures/Linegraph/linegraph_dataformat.png"))) ## When easylinegraph_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easylinegraph_back") do args...
        easymain() ## When easylinegraph_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easylinegraph_plot") do args... ## When easylinegraph_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            easylinegraph_events() ## When easylinegraph_plot_button is pressed, easylinegraph_events() is executed.
        catch
            @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
        end
    end

    ## Defining function that keeps the function easylinegraph_plot() running until true boolean value is returned
    function easylinegraph_events()
        @async while true ## Syncing all processes above
            Plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end
end #function easylinegraph()

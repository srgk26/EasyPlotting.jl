#### Main code for boxandwhisker plot
function easyboxandwhisker()
    ## Defining easyboxandwhisker_input widgets for user inputs
    function easyboxandwhisker_inputs()
        easyboxandwhisker_dataformat_button = html"""<button onclick='Blink.msg("easyboxandwhisker_dataformat", "foo")'>Dataset format</button>""" ## Click to view dataset format
        easyboxandwhisker_colours = Interact.dropdown(["algae", "amp", "balance", "bgy", "bgyw", "bjy", "bkr", "bky", "blues", "bluesreds", "bmw", "colorwheel", "coolwarm", "dimgray", "fire", "curl", "dark_grad", "darkrainbow", "darktest",
                                                    "deep", "delta", "dense", "gray", "grays", "greens", "gwv", "haline", "heat", "ice", "inferno", "isolum", "juno_grad", "kb", "kdc", "kg", "kgy", "kr", "lightrainbow", "lighttest",
                                                    "lime_grad", "magma", "matter", "orange_grad", "oxy", "phase", "plasma", "pu_or", "rainbow", "reds", "redsblues", "sand_grad", "solarized_grad", "solarized_light_grad", "solar", "speed",
                                                    "tempo", "thermal", "turbid", "viridis", "Blues", "BrBG", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "OrRd", "Oranges", "PRGn", "PiYG", "PuBu", "PuBuGn", "PuOr", "PuRd", "Purples",
                                                    "RdBu", "RdGy", "RdPu", "RdYlBu", "RdYlGn", "Reds", "Spectral", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd"]) ## Choose boxandwhisker colours
        easyboxandwhisker_scale = Interact.dropdown(["None", "loge", "log2", "log10"])  ## Choose logarithmic scaling options
        easyboxandwhisker_size1 = Interact.textbox("Default: x-axis = 600") ## Choose x-axis figure size
        easyboxandwhisker_size2 = Interact.textbox("Default: y-axis = 400") ## Choose y-axis figure size
        easyboxandwhisker_back_button = html"""<button onclick='Blink.msg("easyboxandwhisker_back", "foo")'>Go back</button>""" ## Go-back button
        easyboxandwhisker_plot_button = html"""<button onclick='Blink.msg("easyboxandwhisker_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easyboxandwhisker_dataformat_button"=>easyboxandwhisker_dataformat_button, "easyboxandwhisker_colours"=>easyboxandwhisker_colours, "easyboxandwhisker_scale"=>easyboxandwhisker_scale, "easyboxandwhisker_size1"=>easyboxandwhisker_size1, "easyboxandwhisker_size2"=>easyboxandwhisker_size2, "easyboxandwhisker_back_button"=>easyboxandwhisker_back_button, "easyboxandwhisker_plot_button"=>easyboxandwhisker_plot_button]) ## Consolidating all widgets
    end

    easyboxandwhisker_intro1 = "This section provides additional 'Box and Whisker' specific configuration options that you could select below to further customise your Box and Whisker plot."
    easyboxandwhisker_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easyboxandwhisker_intro3 = "Now please select options for Box and Whisker:"

    ## Designing easyboxandwhisker_page layout
    easyboxandwhisker_page = Interact.node(:html,
                                style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                                Interact.node(:p, easyboxandwhisker_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, easyboxandwhisker_intro2), Interact.pad(0.25, easyboxandwhisker_inputs()["easyboxandwhisker_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, easyboxandwhisker_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Box and Whisker plot:"), Interact.pad(0.25, easyboxandwhisker_inputs()["easyboxandwhisker_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easyboxandwhisker_inputs()["easyboxandwhisker_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Enter plot size (numbers only):"), Interact.pad(0.25, easyboxandwhisker_inputs()["easyboxandwhisker_size1"]), Interact.pad(0.25, easyboxandwhisker_inputs()["easyboxandwhisker_size2"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.25, easyboxandwhisker_inputs()["easyboxandwhisker_back_button"]), Interact.pad(0.25, easyboxandwhisker_inputs()["easyboxandwhisker_plot_button"])), style=Dict(:position => "absolute", :left => "650px")))

    Blink.body!(w, easyboxandwhisker_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Box and Whisker") ## Adding title to Blink window 'w'

    ## Main function code to plot boxandwhisker, using user-defined input options
    function easyboxandwhisker_plot()
        if easyboxandwhisker_inputs()["easyboxandwhisker_size1"][]::String == "" ## If no user-input for plot size
            if easyboxandwhisker_inputs()["easyboxandwhisker_scale"][] == "None" ## For no logarithmic scaling
                StatsPlots.boxplot(convert(Matrix, df[:,2:end]), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputs()["easyboxandwhisker_colours"][]::String), legend=false)
                StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                return true ## Returns true value, thereby stopping while loop that keeps the process running
            elseif easyboxandwhisker_inputs()["easyboxandwhisker_scale"][] == "loge" ## For loge logarithmic scaling
                StatsPlots.boxplot(log.(convert(Matrix, df[:,2:end])), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputs()["easyboxandwhisker_colours"][]::String), legend=false)
                StatsPlots.gui()
                return true
            elseif easyboxandwhisker_inputs()["easyboxandwhisker_scale"][] == "log2" ## For log2 logarithmic scaling
                StatsPlots.boxplot(log2.(convert(Matrix, df[:,2:end])), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputs()["easyboxandwhisker_colours"][]::String), legend=false)
                StatsPlots.gui()
                return true
            elseif easyboxandwhisker_inputs()["easyboxandwhisker_scale"][] == "log10" ## For log10 logarithmic scaling
                StatsPlots.boxplot(log10.(convert(Matrix, df[:,2:end])), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputs()["easyboxandwhisker_colours"][]::String), legend=false)
                StatsPlots.gui()
                return true
            end
        else ## If plot size is defined by user
            if easyboxandwhisker_inputs()["easyboxandwhisker_scale"][] == "None" ## For no logarithmic scaling
                StatsPlots.boxplot(convert(Matrix, df[:,2:end]), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputs()["easyboxandwhisker_colours"][]::String), size=(parse(Float64, easyboxandwhisker_inputs()["easyboxandwhisker_size1"][]), parse(Float64, easyboxandwhisker_inputs()["easyboxandwhisker_size2"][])), legend=false)
                StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                return true ## Returns true value, thereby stopping while loop that keeps the process running
            elseif easyboxandwhisker_inputs()["easyboxandwhisker_scale"][] == "loge" ## For loge logarithmic scaling
                StatsPlots.boxplot(log.(convert(Matrix, df[:,2:end])), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputs()["easyboxandwhisker_colours"][]::String), size=(parse(Float64, easyboxandwhisker_inputs()["easyboxandwhisker_size1"][]), parse(Float64, easyboxandwhisker_inputs()["easyboxandwhisker_size2"][])), legend=false)
                StatsPlots.gui()
                return true
            elseif easyboxandwhisker_inputs()["easyboxandwhisker_scale"][] == "log2" ## For log2 logarithmic scaling
                StatsPlots.boxplot(log2.(convert(Matrix, df[:,2:end])), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputs()["easyboxandwhisker_colours"][]::String), size=(parse(Float64, easyboxandwhisker_inputs()["easyboxandwhisker_size1"][]), parse(Float64, easyboxandwhisker_inputs()["easyboxandwhisker_size2"][])), legend=false)
                StatsPlots.gui()
                return true
            elseif easyboxandwhisker_inputs()["easyboxandwhisker_scale"][] == "log10" ## For log10 logarithmic scaling
                StatsPlots.boxplot(log10.(convert(Matrix, df[:,2:end])), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputs()["easyboxandwhisker_colours"][]::String), size=(parse(Float64, easyboxandwhisker_inputs()["easyboxandwhisker_size1"][]), parse(Float64, easyboxandwhisker_inputs()["easyboxandwhisker_size2"][])), legend=false)
                StatsPlots.gui()
                return true
            end
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easyboxandwhisker_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(easyplotting)[1:end-19], "Figures/BoxandWhisker/boxandwhisker_dataformat.png"))) ## When easyboxandwhisker_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easyboxandwhisker_back") do args...
        easymain() ## When easyboxandwhisker_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easyboxandwhisker_plot") do args... ## When easyboxandwhisker_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            easyboxandwhisker_events() ## When easyboxandwhisker_plot_button is pressed, easyboxandwhisker_events() is executed.
        catch
            @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
        end
    end

    ## Defining function that keeps the function easyboxandwhisker_plot() running until true boolean value is returned
    function easyboxandwhisker_events()
        @async while true ## Syncing all processes above
            Plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end
end #function easyboxandwhisker()

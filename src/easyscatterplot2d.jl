#### Main code for scatterplot2d plot
function easyscatterplot2d()
    ## Defining easyscatterplot2d_input widgets for user inputs
    function easyscatterplot2d_inputs()
        easyscatterplot2d_dataformat_button = html"""<button onclick='Blink.msg("easyscatterplot2d_dataformat", "foo")'>Dataset format</button>""" ## Click to view dataset format
        easyscatterplot2d_colours = Interact.dropdown(["algae", "amp", "balance", "bgy", "bgyw", "bjy", "bkr", "bky", "blues", "bluesreds", "bmw", "colorwheel", "coolwarm", "dimgray", "fire", "curl", "dark_grad", "darkrainbow", "darktest",
                                                    "deep", "delta", "dense", "gray", "grays", "greens", "gwv", "haline", "heat", "ice", "inferno", "isolum", "juno_grad", "kb", "kdc", "kg", "kgy", "kr", "lightrainbow", "lighttest",
                                                    "lime_grad", "magma", "matter", "orange_grad", "oxy", "phase", "plasma", "pu_or", "rainbow", "reds", "redsblues", "sand_grad", "solarized_grad", "solarized_light_grad", "solar", "speed",
                                                    "tempo", "thermal", "turbid", "viridis", "Blues", "BrBG", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "OrRd", "Oranges", "PRGn", "PiYG", "PuBu", "PuBuGn", "PuOr", "PuRd", "Purples",
                                                    "RdBu", "RdGy", "RdPu", "RdYlBu", "RdYlGn", "Reds", "Spectral", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd"]) ## Choose scatterplot2d colours
        easyscatterplot2d_scale = Interact.dropdown(["None", "loge", "log2", "log10"]) ## Choose logarithmic scaling options
        easyscatterplot2d_size1 = Interact.textbox("Default: x-axis = 600") ## Choose x-axis figure size
        easyscatterplot2d_size2 = Interact.textbox("Default: y-axis = 400") ## Choose y-axis figure size
        easyscatterplot2d_back_button = html"""<button onclick='Blink.msg("easyscatterplot2d_back", "foo")'>Go back</button>""" ## Go-back button
        easyscatterplot2d_plot_button = html"""<button onclick='Blink.msg("easyscatterplot2d_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easyscatterplot2d_dataformat_button"=>easyscatterplot2d_dataformat_button, "easyscatterplot2d_colours"=>easyscatterplot2d_colours, "easyscatterplot2d_scale"=>easyscatterplot2d_scale, "easyscatterplot2d_size1"=>easyscatterplot2d_size1, "easyscatterplot2d_size2"=>easyscatterplot2d_size2, "easyscatterplot2d_back_button"=>easyscatterplot2d_back_button, "easyscatterplot2d_plot_button"=>easyscatterplot2d_plot_button]) ## Consolidating all widgets
    end
    easyscatterplot2d_inputsfunc = easyscatterplot2d_inputs()

    easyscatterplot2d_intro1 = "This section provides additional 'Scatterplot 2D' specific configuration options that you could select below to further customise your Scatterplot 2D."
    easyscatterplot2d_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easyscatterplot2d_intro3 = "Now please select options for Scatterplot 2D:"

    ## Designing easyscatterplot2d_page layout
    easyscatterplot2d_page = Interact.node(:html,
                                style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                                Interact.node(:p, easyscatterplot2d_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, easyscatterplot2d_intro2), Interact.pad(0.25, easyscatterplot2d_inputsfunc["easyscatterplot2d_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, easyscatterplot2d_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Scatterplot 2D:"), Interact.pad(0.25, easyscatterplot2d_inputsfunc["easyscatterplot2d_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easyscatterplot2d_inputsfunc["easyscatterplot2d_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Enter plot size (numbers only):"), Interact.pad(0.25, easyscatterplot2d_inputsfunc["easyscatterplot2d_size1"]), Interact.pad(0.25, easyscatterplot2d_inputsfunc["easyscatterplot2d_size2"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.25, easyscatterplot2d_inputsfunc["easyscatterplot2d_back_button"]), Interact.pad(0.25, easyscatterplot2d_inputsfunc["easyscatterplot2d_plot_button"])), style=Dict(:position => "absolute", :left => "650px")))

    Blink.body!(w, easyscatterplot2d_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Scatterplot 2D") ## Adding title to Blink window 'w'

    ## Main function code to plot scatterplot2d, using user-defined input options
    function easyscatterplot2d_plot()
        if easyscatterplot2d_inputsfunc["easyscatterplot2d_size1"][]::String == "" ## If no user-input for plot size
            if easyscatterplot2d_inputsfunc["easyscatterplot2d_scale"][] == "None" ## For no logarithmic scaling
                StatsPlots.scatter(collect(df[:,2]), collect(df[:,3]), xlabel = string(names(df)[2]), ylabel = string(names(df)[3]), color=Symbol(easyscatterplot2d_inputsfunc["easyscatterplot2d_colours"][]::String), legend=false)
                StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                return true ## Returns true value, thereby stopping while loop that keeps the process running
            elseif easyscatterplot2d_inputsfunc["easyscatterplot2d_scale"][] == "loge" ## For loge logarithmic scaling
                StatsPlots.scatter(log.(collect(df[:,2])), log.(collect(df[:,3])), xlabel = string(names(df)[2]), ylabel = string(names(df)[3]), color=Symbol(easyscatterplot2d_inputsfunc["easyscatterplot2d_colours"][]::String), legend=false)
                StatsPlots.gui()
                return true
            elseif easyscatterplot2d_inputsfunc["easyscatterplot2d_scale"][] == "log2" ## For log2 logarithmic scaling
                StatsPlots.scatter(log2.(collect(df[:,2])), log2.(collect(df[:,3])), xlabel = string(names(df)[2]), ylabel = string(names(df)[3]), color=Symbol(easyscatterplot2d_inputsfunc["easyscatterplot2d_colours"][]::String), legend=false)
                StatsPlots.gui()
                return true
            elseif easyscatterplot2d_inputsfunc["easyscatterplot2d_scale"][] == "log10" ## For log10 logarithmic scaling
                StatsPlots.scatter(log10.(collect(df[:,2])), log10.(collect(df[:,3])), xlabel = string(names(df)[2]), ylabel = string(names(df)[3]), color=Symbol(easyscatterplot2d_inputsfunc["easyscatterplot2d_colours"][]::String), legend=false)
                StatsPlots.gui()
                return true
            end
        else ## If plot size is defined by user
            if easyscatterplot2d_inputsfunc["easyscatterplot2d_scale"][] == "None" ## For no logarithmic scaling
                StatsPlots.scatter(collect(df[:,2]), collect(df[:,3]), xlabel = string(names(df)[2]), ylabel = string(names(df)[3]), color=Symbol(easyscatterplot2d_inputsfunc["easyscatterplot2d_colours"][]::String), size=(parse(Float64, easyscatterplot2d_inputsfunc["easyscatterplot2d_size1"][]), parse(Float64, easyscatterplot2d_inputsfunc["easyscatterplot2d_size2"][])), legend=false)
                StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                return true ## Returns true value, thereby stopping while loop that keeps the process running
            elseif easyscatterplot2d_inputsfunc["easyscatterplot2d_scale"][] == "loge" ## For loge logarithmic scaling
                StatsPlots.scatter(log.(collect(df[:,2])), log.(collect(df[:,3])), xlabel = string(names(df)[2]), ylabel = string(names(df)[3]), color=Symbol(easyscatterplot2d_inputsfunc["easyscatterplot2d_colours"][]::String), size=(parse(Float64, easyscatterplot2d_inputsfunc["easyscatterplot2d_size1"][]), parse(Float64, easyscatterplot2d_inputsfunc["easyscatterplot2d_size2"][])), legend=false)
                StatsPlots.gui()
                return true
            elseif easyscatterplot2d_inputsfunc["easyscatterplot2d_scale"][] == "log2" ## For log2 logarithmic scaling
                StatsPlots.scatter(log2.(collect(df[:,2])), log2.(collect(df[:,3])), xlabel = string(names(df)[2]), ylabel = string(names(df)[3]), color=Symbol(easyscatterplot2d_inputsfunc["easyscatterplot2d_colours"][]::String), size=(parse(Float64, easyscatterplot2d_inputsfunc["easyscatterplot2d_size1"][]), parse(Float64, easyscatterplot2d_inputsfunc["easyscatterplot2d_size2"][])), legend=false)
                StatsPlots.gui()
                return true
            elseif easyscatterplot2d_inputsfunc["easyscatterplot2d_scale"][] == "log10" ## For log10 logarithmic scaling
                StatsPlots.scatter(log10.(collect(df[:,2])), log10.(collect(df[:,3])), xlabel = string(names(df)[2]), ylabel = string(names(df)[3]), color=Symbol(easyscatterplot2d_inputsfunc["easyscatterplot2d_colours"][]::String), size=(parse(Float64, easyscatterplot2d_inputsfunc["easyscatterplot2d_size1"][]), parse(Float64, easyscatterplot2d_inputsfunc["easyscatterplot2d_size2"][])), legend=false)
                StatsPlots.gui()
                return true
            end
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easyscatterplot2d_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(easyplotting)[1:end-19], "Figures/Scatterplot2d/scatterplot2d_dataformat.png"))) ## When easyscatterplot2d_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easyscatterplot2d_back") do args...
        easymain() ## When easyscatterplot2d_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easyscatterplot2d_plot") do args... ## When easyscatterplot2d_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            easyscatterplot2d_events() ## When easyscatterplot2d_plot_button is pressed, easyscatterplot2d_events() is executed.
        catch
            @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
        end
    end

    ## Defining function that keeps the function easyscatterplot2d_plot() running until true boolean value is returned
    function easyscatterplot2d_events()
        @async while true ## Syncing all processes above
            Plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end
end #function easyscatterplot2d()

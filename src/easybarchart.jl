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
        easybarchart_scale = Interact.dropdown(["None", "loge", "log2", "log10"]) ## Choose logarithmic scaling options
        easybarchart_size1 = Interact.textbox("Default: x-axis = 600") ## Choose x-axis figure size
        easybarchart_size2 = Interact.textbox("Default: y-axis = 400") ## Choose y-axis figure size
        easybarchart_back_button = html"""<button onclick='Blink.msg("easybarchart_back", "foo")'>Go back</button>""" ## Go-back button
        easybarchart_plot_button = html"""<button onclick='Blink.msg("easybarchart_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easybarchart_dataformat_button"=>easybarchart_dataformat_button, "easybarchart_colours"=>easybarchart_colours, "easybarchart_scale"=>easybarchart_scale, "easybarchart_size1"=>easybarchart_size1, "easybarchart_size2"=>easybarchart_size2, "easybarchart_back_button"=>easybarchart_back_button, "easybarchart_plot_button"=>easybarchart_plot_button]) ## Consolidating all widgets
    end

    easybarchart_intro1 = "This section provides additional 'Bar Chart' specific configuration options that you could select below to further customise your Bar Chart."
    easybarchart_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easybarchart_intro3 = "Now please select options for Bar Chart:"

    ## Designing easybarchart_page layout
    easybarchart_page = Interact.node(:html,
                            style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                            Interact.node(:p, easybarchart_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, easybarchart_intro2), Interact.pad(0.25, easybarchart_inputs()["easybarchart_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, easybarchart_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Bar Chart:"), Interact.pad(0.25, easybarchart_inputs()["easybarchart_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easybarchart_inputs()["easybarchart_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Enter plot size (numbers only):"), Interact.pad(0.25, easybarchart_inputs()["easybarchart_size1"]), Interact.pad(0.25, easybarchart_inputs()["easybarchart_size2"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.25, easybarchart_inputs()["easybarchart_back_button"]), Interact.pad(0.25, easybarchart_inputs()["easybarchart_plot_button"])), style=Dict(:position => "absolute", :left => "650px")))

    Blink.body!(w, easybarchart_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Bar Chart") ## Adding title to Blink window 'w'

    ## Main function code to plot barchart, using user-defined input options
    function easybarchart_plot()
        if easybarchart_inputs()["easybarchart_size1"][]::String == "" ## If no user-input for plot size
            if easybarchart_inputs()["easybarchart_scale"][] == "None" ## For no logarithmic scaling
                StatsPlots.bar(collect(df[:,2]), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputs()["easybarchart_colours"][]::String), legend=false)
                StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                return true ## Returns true value, thereby stopping while loop that keeps the process running
            elseif easybarchart_inputs()["easybarchart_scale"][] == "loge" ## For loge logarithmic scaling
                StatsPlots.bar(log.(collect(df[:,2])), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputs()["easybarchart_colours"][]::String), legend=false)
                StatsPlots.gui()
                return true
            elseif easybarchart_inputs()["easybarchart_scale"][] == "log2" ## For log2 logarithmic scaling
                StatsPlots.bar(log2.(collect(df[:,2])), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputs()["easybarchart_colours"][]::String), legend=false)
                StatsPlots.gui()
                return true
            elseif easybarchart_inputs()["easybarchart_scale"][] == "log10" ## For log10 logarithmic scaling
                StatsPlots.bar(log10.(collect(df[:,2])), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputs()["easybarchart_colours"][]::String), legend=false)
                StatsPlots.gui()
                return true
            end
        else ## If plot size is defined by user
            if easybarchart_inputs()["easybarchart_scale"][] == "None" ## For no logarithmic scaling
                StatsPlots.bar(collect(df[:,2]), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputs()["easybarchart_colours"][]::String), size=(parse(Float64, easybarchart_inputs()["easybarchart_size1"][]), parse(Float64, easybarchart_inputs()["easybarchart_size2"][])), legend=false)
                StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                return true ## Returns true value, thereby stopping while loop that keeps the process running
            elseif easybarchart_inputs()["easybarchart_scale"][] == "loge" ## For loge logarithmic scaling
                StatsPlots.bar(log.(collect(df[:,2])), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputs()["easybarchart_colours"][]::String), size=(parse(Float64, easybarchart_inputs()["easybarchart_size1"][]), parse(Float64, easybarchart_inputs()["easybarchart_size2"][])), legend=false)
                StatsPlots.gui()
                return true
            elseif easybarchart_inputs()["easybarchart_scale"][] == "log2" ## For log2 logarithmic scaling
                StatsPlots.bar(log2.(collect(df[:,2])), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputs()["easybarchart_colours"][]::String), size=(parse(Float64, easybarchart_inputs()["easybarchart_size1"][]), parse(Float64, easybarchart_inputs()["easybarchart_size2"][])), legend=false)
                StatsPlots.gui()
                return true
            elseif easybarchart_inputs()["easybarchart_scale"][] == "log10" ## For log10 logarithmic scaling
                StatsPlots.bar(log10.(collect(df[:,2])), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputs()["easybarchart_colours"][]::String), size=(parse(Float64, easybarchart_inputs()["easybarchart_size1"][]), parse(Float64, easybarchart_inputs()["easybarchart_size2"][])), legend=false)
                StatsPlots.gui()
                return true
            end
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easybarchart_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(easyplotting)[1:end-19], "Figures/Barchart/barchart_dataformat.png"))) ## When easybarchart_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easybarchart_back") do args...
        easymain() ## When easybarchart_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easybarchart_plot") do args... ## When easybarchart_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            easybarchart_events() ## When easybarchart_plot_button is pressed, easybarchart_events() is executed.
        catch
            @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
        end
    end

    ## Defining function that keeps the function easybarchart_plot() running until true boolean value is returned
    function easybarchart_events()
        @async while true ## Syncing all processes above
            Plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end
end #function easybarchart()

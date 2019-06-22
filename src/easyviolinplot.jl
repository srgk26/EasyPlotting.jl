#### Main code for violinplot plot
function easyviolinplot()
    ## Defining easyviolinplot_input widgets for user inputs
    function easyviolinplot_inputs()
        easyviolinplot_dataformat_button = html"""<button onclick='Blink.msg("easyviolinplot_dataformat", "foo")'>Dataset format</button>""" ## Click to view dataset format
        easyviolinplot_colours = Interact.dropdown(["Default", "Blues", "Reds", "Purples", "Greens", "mako", "BuGn_r", "cubehelix", "BrBG", "RdBu_r", "coolwarm"]) ## Choose violinplot colours
        easyviolinplot_scale = Interact.dropdown(["None", "loge", "log2", "log10"]) ## Choose logarithmic scaling options
        easyviolinplot_inner = Interact.dropdown(["None", "box", "quartile", "stick"]) ## Choose violinplot interior representation options
        easyviolinplot_back_button = html"""<button onclick='Blink.msg("easyviolinplot_back", "foo")'>Go back</button>""" ## Go-back button
        easyviolinplot_plot_button = html"""<button onclick='Blink.msg("easyviolinplot_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easyviolinplot_dataformat_button"=>easyviolinplot_dataformat_button, "easyviolinplot_colours"=>easyviolinplot_colours, "easyviolinplot_scale"=>easyviolinplot_scale, "easyviolinplot_inner"=>easyviolinplot_inner, "easyviolinplot_back_button"=>easyviolinplot_back_button, "easyviolinplot_plot_button"=>easyviolinplot_plot_button]) ## Consolidating all widgets
    end
    easyviolinplot_inputsfunc = easyviolinplot_inputs()

    easyviolinplot_intro1 = "This section provides additional 'Violinplot' specific configuration options that you could select below to further customise your Violinplot."
    easyviolinplot_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easyviolinplot_intro3 = "Now please select options for Violinplot:"

    ## Designing easyviolinplot_page layout
    easyviolinplot_page = Interact.node(:html,
                            style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                            Interact.node(:p, easyviolinplot_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, easyviolinplot_intro2), Interact.pad(0.25, easyviolinplot_inputsfunc["easyviolinplot_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, easyviolinplot_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Violinplot:"), Interact.pad(0.25, easyviolinplot_inputsfunc["easyviolinplot_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easyviolinplot_inputsfunc["easyviolinplot_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select Violinplot interior data representation options:"), Interact.pad(0.25, easyviolinplot_inputsfunc["easyviolinplot_inner"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.25, easyviolinplot_inputsfunc["easyviolinplot_back_button"]), Interact.pad(0.25, easyviolinplot_inputsfunc["easyviolinplot_plot_button"])), style=Dict(:position => "absolute", :left => "650px")))

    Blink.body!(w, easyviolinplot_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Violinplot") ## Adding title to Blink window 'w'

    ## Defining function to save violinplot plot
    function easyviolinplot_fig()
        tmp_violinplot = joinpath(mktempdir(), "tmp_violinplot.png") ## Assign temporary filename for violinplot produced
        Seaborn.savefig(tmp_violinplot) ## Saves violinplot figure
        run(`open $tmp_violinplot`) ## Open temporary violinplot figure file
    end

    ## Main function code to plot violinplot, using user-defined input options
    function easyviolinplot_plot()
        if easyviolinplot_inputsfunc["easyviolinplot_scale"][] == "None" ## For no logarithmic scaling
            if easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "None" ## For no violinplot interior representation options
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default" ## If no user-input for plot colours
                    Seaborn.violinplot(x=collect(df[:,2]), y=collect(df[:,3])) ## Seaborn violinplot plotting
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig() ## Call easyviolinplot_fig() function defined above
                    return true ## Returns true value, thereby stopping while loop that keeps the process running
                else ## If plot colours is defined by user
                    Seaborn.violinplot(x=collect(df[:,2]), y=collect(df[:,3]), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String))
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            elseif easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "box" ## For "box" violinplot interior representation options
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=collect(df[:,2]), y=collect(df[:,3]), inner="box")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=collect(df[:,2]), y=collect(df[:,3]), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String), inner="box")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            elseif easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "quartile" ## For "quartile" violinplot interior representation options
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=collect(df[:,2]), y=collect(df[:,3]), inner="quartile")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=collect(df[:,2]), y=collect(df[:,3]), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String), inner="quartile")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            elseif easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "stick" ## For "stick" violinplot interior representation options
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=collect(df[:,2]), y=collect(df[:,3]), inner="stick")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=collect(df[:,2]), y=collect(df[:,3]), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String), inner="stick")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            end
        elseif easyviolinplot_inputsfunc["easyviolinplot_scale"][] == "loge" ## For loge logarithmic scaling
            if easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "None"
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=log.(collect(df[:,2])), y=log.(collect(df[:,3])))
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=log.(collect(df[:,2])), y=log.(collect(df[:,3])), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String))
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            elseif easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "box"
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=log.(collect(df[:,2])), y=log.(collect(df[:,3])), inner="box")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=log.(collect(df[:,2])), y=log.(collect(df[:,3])), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String), inner="box")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            elseif easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "quartile"
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=log.(collect(df[:,2])), y=log.(collect(df[:,3])), inner="quartile")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=log.(collect(df[:,2])), y=log.(collect(df[:,3])), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String), inner="quartile")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            elseif easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "stick"
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=log.(collect(df[:,2])), y=log.(collect(df[:,3])), inner="stick")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=log.(collect(df[:,2])), y=log.(collect(df[:,3])), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String), inner="stick")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            end
        elseif easyviolinplot_inputsfunc["easyviolinplot_scale"][] == "log2" ## For log2 logarithmic scaling
            if easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "None"
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=log2.(collect(df[:,2])), y=log2.(collect(df[:,3])))
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=log2.(collect(df[:,2])), y=log2.(collect(df[:,3])), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String))
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            elseif easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "box"
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=log2.(collect(df[:,2])), y=log2.(collect(df[:,3])), inner="box")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=log2.(collect(df[:,2])), y=log2.(collect(df[:,3])), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String), inner="box")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            elseif easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "quartile"
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=log2.(collect(df[:,2])), y=log2.(collect(df[:,3])), inner="quartile")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=log2.(collect(df[:,2])), y=log2.(collect(df[:,3])), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String), inner="quartile")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            elseif easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "stick"
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=log2.(collect(df[:,2])), y=log2.(collect(df[:,3])), inner="stick")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=log2.(collect(df[:,2])), y=log2.(collect(df[:,3])), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String), inner="stick")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            end
        elseif easyviolinplot_inputsfunc["easyviolinplot_scale"][] == "log10" ## For log10 logarithmic scaling
            if easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "None"
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=log10.(collect(df[:,2])), y=log10.(collect(df[:,3])))
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=log10.(collect(df[:,2])), y=log10.(collect(df[:,3])), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String))
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            elseif easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "box" ## For row clustering option
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=log10.(collect(df[:,2])), y=log10.(collect(df[:,3])), inner="box")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=log10.(collect(df[:,2])), y=log10.(collect(df[:,3])), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String), inner="box")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            elseif easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "quartile"
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=log10.(collect(df[:,2])), y=log10.(collect(df[:,3])), inner="quartile")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=log10.(collect(df[:,2])), y=log10.(collect(df[:,3])), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String), inner="quartile")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            elseif easyviolinplot_inputsfunc["easyviolinplot_inner"][] == "stick"
                if easyviolinplot_inputsfunc["easyviolinplot_colours"][] == "Default"
                    Seaborn.violinplot(x=log10.(collect(df[:,2])), y=log10.(collect(df[:,3])), inner="stick")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                else
                    Seaborn.violinplot(x=log10.(collect(df[:,2])), y=log10.(collect(df[:,3])), palette=(easyviolinplot_inputsfunc["easyviolinplot_colours"][]::String), inner="stick")
                    Seaborn.xlabel(string(names(df)[2]))
                    Seaborn.ylabel(string(names(df)[3]))
                    easyviolinplot_fig()
                    return true
                end
            end
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easyviolinplot_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(easyplotting)[1:end-19], "Figures/Violinplot/violinplot_dataformat.png"))) ## When easyviolinplot_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easyviolinplot_back") do args...
        easymain() ## When easyviolinplot_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easyviolinplot_plot") do args... ## When easyviolinplot_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            easyviolinplot_events() ## When easyviolinplot_plot_button is pressed, easyviolinplot_events() is executed.
        catch
            @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
        end
    end

    ## Defining function that keeps the function easyviolinplot_plot() running until true boolean value is returned
    function easyviolinplot_events()
        @async while true ## Syncing all processes above
            Plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end
end #function easyviolinplot()

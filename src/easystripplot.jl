#### Main code for stripplot plot
function easystripplot()
    w = Blink.Window() ## Opening new Blink Window

    ## Defining easystripplot_input widgets for user inputs
    function easystripplot_inputs()
        easystripplot_file = Interact.filepicker(accept=[".xlsx", ".csv", ".txt"]) ## Restricting file input types to .xlsx/.csv/.txt
        easystripplot_sheet = Interact.textbox("Excel sheet name") ## Need sheet name for .xlsx files
        easystripplot_dataformat_button = html"""<button onclick='Blink.msg("easystripplot_dataformat", "foo")'>Dataset format</button>""" ## Click to view dataset format
        easystripplot_dotsize = Interact.textbox("Default: dot size = 4") ## Choose dot size
        easystripplot_colours = Interact.dropdown(["Default", "Blues", "Reds", "Purples", "Greens", "mako", "BuGn_r", "cubehelix", "BrBG", "RdBu_r", "coolwarm"]) ## Choose stripplot colours
        easystripplot_scale = Interact.dropdown(["None", "loge", "log2", "log10"]) ## Choose logarithmic scaling options
        easystripplot_jitter = Interact.dropdown(["false", "true"]) ## Choose jittering options
        easystripplot_back_button = html"""<button onclick='Blink.msg("easystripplot_back", "foo")'>Go back</button>""" ## Go-back button
        easystripplot_plot_button = html"""<button onclick='Blink.msg("easystripplot_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easystripplot_file"=>easystripplot_file, "easystripplot_sheet"=>easystripplot_sheet, "easystripplot_dataformat_button"=>easystripplot_dataformat_button, "easystripplot_dotsize"=>easystripplot_dotsize, "easystripplot_colours"=>easystripplot_colours, "easystripplot_scale"=>easystripplot_scale, "easystripplot_jitter"=>easystripplot_jitter, "easystripplot_back_button"=>easystripplot_back_button, "easystripplot_plot_button"=>easystripplot_plot_button]) ## Consolidating all widgets
    end
    easystripplot_inputsFn = easystripplot_inputs()

    easystripplot_intro1 = "This section provides additional 'Stripplot' specific configuration options that you could select below to further customise your Stripplot."
    easystripplot_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easystripplot_intro3 = "Now please upload your dataset below and select options for Stripplot:"

    ## Designing easystripplot_page layout
    easystripplot_page = Interact.node(:html,
                            style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                            Interact.node(:p, easystripplot_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, easystripplot_intro2), Interact.pad(0.25, easystripplot_inputsFn["easystripplot_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, easystripplot_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "Upload data file - only .txt/.csv/.xlsx file extensions accepted:"), Interact.pad(0.25, easystripplot_inputsFn["easystripplot_file"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "If excel .xlsx file, pls also enter sheet name (case & space sensitive):"), Interact.pad(0.25, easystripplot_inputsFn["easystripplot_sheet"])), style=Dict(:color=>"#F4A460", :size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Enter plot size (numbers only):"), Interact.pad(0.25, easystripplot_inputsFn["easystripplot_dotsize"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Stripplot:"), Interact.pad(0.25, easystripplot_inputsFn["easystripplot_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easystripplot_inputsFn["easystripplot_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select jitter options:"), Interact.pad(0.25, easystripplot_inputsFn["easystripplot_jitter"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.25, easystripplot_inputsFn["easystripplot_back_button"]), Interact.pad(0.25, easystripplot_inputsFn["easystripplot_plot_button"])), style=Dict(:position => "absolute", :left => "650px")))

    Blink.body!(w, easystripplot_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Stripplot") ## Adding title to Blink window 'w'

    ## Defining function to save stripplot plot
    function easystripplot_fig()
        tmp_stripplot = joinpath(mktempdir(), "tmp_stripplot.png") ## Assign temporary filename for stripplot produced
        Seaborn.savefig(tmp_stripplot) ## Saves stripplot figure
        run(`open $tmp_stripplot`) ## Open temporary stripplot figure file
    end

    ## Main function code to plot stripplot, using user-defined input options
    function easystripplot_plot()
        if easystripplot_inputsFn["easystripplot_scale"][] == "None" ## For no logarithmic scaling
            if easystripplot_inputsFn["easystripplot_jitter"][] == "false" ## For no jitter option
                if easystripplot_inputsFn["easystripplot_dotsize"][]::String == "" ## If no user-input for plot size
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default" ## If no user-input for plot colours
                        Seaborn.stripplot(data=convert(Matrix, df[:,2:end]), size=4, jitter=false) ## Seaborn stripplot plotting
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig() ## Call easystripplot_fig() function defined above
                        return true ## Returns true value, thereby stopping while loop that keeps the process running
                    else ## If plot colours is defined by user
                        Seaborn.stripplot(data=convert(Matrix, df[:,2:end]), size=4, palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                else ## If plot size is defined by user
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=convert(Matrix, df[:,2:end]), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=convert(Matrix, df[:,2:end]), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                end
            elseif easystripplot_inputsFn["easystripplot_jitter"][] == "true" ## With jitter option
                if easystripplot_inputsFn["easystripplot_dotsize"][]::String == ""
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=convert(Matrix, df[:,2:end]), size=4, jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=convert(Matrix, df[:,2:end]), size=4, palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                else
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=convert(Matrix, df[:,2:end]), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=convert(Matrix, df[:,2:end]), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                end
            end
        elseif easystripplot_inputsFn["easystripplot_scale"][] == "loge" ## For loge logarithmic scaling
            if easystripplot_inputsFn["easystripplot_jitter"][] == "false"
                if easystripplot_inputsFn["easystripplot_dotsize"][]::String == ""
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=log.(convert(Matrix, df[:,2:end])), size=4, jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=log.(convert(Matrix, df[:,2:end])), size=4, palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                else
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=log.(convert(Matrix, df[:,2:end])), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=log.(convert(Matrix, df[:,2:end])), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                end
            elseif easystripplot_inputsFn["easystripplot_jitter"][] == "true"
                if easystripplot_inputsFn["easystripplot_dotsize"][]::String == ""
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=log.(convert(Matrix, df[:,2:end])), size=4, jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=log.(convert(Matrix, df[:,2:end])), size=4, palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                else
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=log.(convert(Matrix, df[:,2:end])), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=log.(convert(Matrix, df[:,2:end])), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                end
            end
        elseif easystripplot_inputsFn["easystripplot_scale"][] == "log2" ## For log2 logarithmic scaling
            if easystripplot_inputsFn["easystripplot_jitter"][] == "false"
                if easystripplot_inputsFn["easystripplot_dotsize"][]::String == ""
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=log2.(convert(Matrix, df[:,2:end])), size=4, jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=log2.(convert(Matrix, df[:,2:end])), size=4, palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                else
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=log2.(convert(Matrix, df[:,2:end])), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=log2.(convert(Matrix, df[:,2:end])), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                end
            elseif easystripplot_inputsFn["easystripplot_jitter"][] == "true"
                if easystripplot_inputsFn["easystripplot_dotsize"][]::String == ""
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=log2.(convert(Matrix, df[:,2:end])), size=4, jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=log2.(convert(Matrix, df[:,2:end])), size=4, palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                else
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=log2.(convert(Matrix, df[:,2:end])), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=log2.(convert(Matrix, df[:,2:end])), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                end
            end
        elseif easystripplot_inputsFn["easystripplot_scale"][] == "log10" ## For log10 logarithmic scaling
            if easystripplot_inputsFn["easystripplot_jitter"][] == "false"
                if easystripplot_inputsFn["easystripplot_dotsize"][]::String == ""
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=log10.(convert(Matrix, df[:,2:end])), size=4, jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=log10.(convert(Matrix, df[:,2:end])), size=4, palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                else
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=log10.(convert(Matrix, df[:,2:end])), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=log10.(convert(Matrix, df[:,2:end])), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=false)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                end
            elseif easystripplot_inputsFn["easystripplot_jitter"][] == "true"
                if easystripplot_inputsFn["easystripplot_dotsize"][]::String == ""
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=log10.(convert(Matrix, df[:,2:end])), size=4, jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=log10.(convert(Matrix, df[:,2:end])), size=4, palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                else
                    if easystripplot_inputsFn["easystripplot_colours"][] == "Default"
                        Seaborn.stripplot(data=log10.(convert(Matrix, df[:,2:end])), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    else
                        Seaborn.stripplot(data=log10.(convert(Matrix, df[:,2:end])), size=(parse(Float64, easystripplot_inputsFn["easystripplot_dotsize"][])), palette=(easystripplot_inputsFn["easystripplot_colours"][]), jitter=true)
                        Seaborn.xticks(0:size(df[:,2:end-1],2), [string(names(df)[i]) for i in 2:size(df,2)])
                        easystripplot_fig()
                        return true
                    end
                end
            end
        end
    end

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easystripplot_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(EasyPlotting)[1:end-19], "Figures/Stripplot/stripplot_dataformat.png"))) ## When easystripplot_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easystripplot_back") do args...
        easymain() ## When easystripplot_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easystripplot_plot") do args... ## When easystripplot_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            if (easystripplot_inputsFn["easystripplot_file"][]::String)[end-3:end] == "xlsx" ## If input file is .xlsx
                global df = DataFrames.DataFrame(XLSX.readtable((easystripplot_inputsFn["easystripplot_file"][]::String), (easystripplot_inputsFn["easystripplot_sheet"][]::String))...) ## Convert dataset to dataframe
            elseif (easystripplot_inputsFn["easystripplot_file"][]::String)[end-2:end] == "csv" ## If input file is .csv
                global df = DataFrames.DataFrame(CSV.read(easystripplot_inputsFn["easystripplot_file"][]::String)) ## Convert dataset to dataframe
            elseif (easystripplot_inputsFn["easystripplot_file"][]::String)[end-2:end] == "txt" ## If input file is .txt
                global df = DataFrames.DataFrame(DelimitedFiles.readdlm(easystripplot_inputsFn["easystripplot_file"][]::String, '\t')) ## Convert dataset to dataframe

                ## Renaming row 1 of df as column names since .txt files return the top row as row 1 instead of column names
                for i in 1:size(df, 2)
                    DataFrames.rename!(df, names(df)[i]=>Symbol(df[1,i]))
                end
                DataFrames.deleterows!(df, 1) ## Deleting row 1 of df
            end

            ## Plot stripplot
            easystripplot_events() ## When easystripplot_plot_button is pressed, easystripplot_events() is executed.
        catch
            ## Alert if sheet name is not entered for excel .xlsx files
            if (easystripplot_inputsFn["easystripplot_file"][]::String)[end-3:end] == "xlsx" && easystripplot_inputsFn["easystripplot_sheet"][]::String == ""
                @js_ w alert("Excel .xlsx sheet name not entered. Kindly enter the sheet name and try again.")
            else
                @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
            end
        end
    end

    ## Defining function that keeps the function easystripplot_plot() running until true boolean value is returned
    function easystripplot_events()
        @async while true ## Syncing all processes above
            easystripplot_plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end
end #function easystripplot()

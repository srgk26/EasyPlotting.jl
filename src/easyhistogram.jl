#### Main code for histogram plot
function easyhistogram()
    w = Blink.Window() ## Opening new Blink Window

    ## Defining easyhistogram_input widgets for user inputs
    function easyhistogram_inputs()
        easyhistogram_file = Interact.filepicker(accept=[".xlsx", ".csv", ".txt"]) ## Restricting file input types to .xlsx/.csv/.txt
        easyhistogram_sheet = Interact.textbox("Excel sheet name") ## Need sheet name for .xlsx files
        easyhistogram_dataformat_button = html"""<button onclick='Blink.msg("easyhistogram_dataformat", "foo")'>Dataset format</button>""" ## Click to view dataset format
        easyhistogram_colours = Interact.dropdown(["algae", "amp", "balance", "bgy", "bgyw", "bjy", "bkr", "bky", "blues", "bluesreds", "bmw", "colorwheel", "coolwarm", "dimgray", "fire", "curl", "dark_grad", "darkrainbow", "darktest",
                                                    "deep", "delta", "dense", "gray", "grays", "greens", "gwv", "haline", "heat", "ice", "inferno", "isolum", "juno_grad", "kb", "kdc", "kg", "kgy", "kr", "lightrainbow", "lighttest",
                                                    "lime_grad", "magma", "matter", "orange_grad", "oxy", "phase", "plasma", "pu_or", "rainbow", "reds", "redsblues", "sand_grad", "solarized_grad", "solarized_light_grad", "solar", "speed",
                                                    "tempo", "thermal", "turbid", "viridis", "Blues", "BrBG", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "OrRd", "Oranges", "PRGn", "PiYG", "PuBu", "PuBuGn", "PuOr", "PuRd", "Purples",
                                                    "RdBu", "RdGy", "RdPu", "RdYlBu", "RdYlGn", "Reds", "Spectral", "YlGn", "YlGnBu", "YlOrBr", "YlOrRd"]) ## Choose histogram colours
        easyhistogram_scale = Interact.dropdown(["None", "loge", "log2", "log10"])  ## Choose logarithmic scaling options
        easyhistogram_size1 = Interact.textbox("Default: x-axis = 600") ## Choose x-axis figure size
        easyhistogram_size2 = Interact.textbox("Default: y-axis = 400") ## Choose y-axis figure size
        easyhistogram_back_button = html"""<button onclick='Blink.msg("easyhistogram_back", "foo")'>Go back</button>""" ## Go-back button
        easyhistogram_plot_button = html"""<button onclick='Blink.msg("easyhistogram_plot", "foo")'>Plot</button>""" ## Plot button
        Interact.Widget(["easyhistogram_file"=>easyhistogram_file, "easyhistogram_sheet"=>easyhistogram_sheet, "easyhistogram_dataformat_button"=>easyhistogram_dataformat_button, "easyhistogram_colours"=>easyhistogram_colours, "easyhistogram_scale"=>easyhistogram_scale, "easyhistogram_size1"=>easyhistogram_size1, "easyhistogram_size2"=>easyhistogram_size2, "easyhistogram_back_button"=>easyhistogram_back_button, "easyhistogram_plot_button"=>easyhistogram_plot_button]) ## Consolidating all widgets
    end
    easyhistogram_inputsFn = easyhistogram_inputs()

    easyhistogram_intro1 = "This section provides additional 'Histogram' specific configuration options that you could select below to further customise your Histogram."
    easyhistogram_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easyhistogram_intro3 = "Now please upload your dataset below and select options for Histogram:"

    ## Designing easyhistogram_page layout
    easyhistogram_page = Interact.node(:html,
                            style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                            Interact.node(:p, easyhistogram_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, easyhistogram_intro2), Interact.pad(0.25, easyhistogram_inputsFn["easyhistogram_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, easyhistogram_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "Upload data file - only .txt/.csv/.xlsx file extensions accepted:"), Interact.pad(0.25, easyhistogram_inputsFn["easyhistogram_file"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "If excel .xlsx file, pls also enter sheet name (case & space sensitive):"), Interact.pad(0.25, easyhistogram_inputsFn["easyhistogram_sheet"])), style=Dict(:color=>"#F4A460", :size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Histogram:"), Interact.pad(0.25, easyhistogram_inputsFn["easyhistogram_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easyhistogram_inputsFn["easyhistogram_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Enter plot size (numbers only):"), Interact.pad(0.25, easyhistogram_inputsFn["easyhistogram_size1"]), Interact.pad(0.25, easyhistogram_inputsFn["easyhistogram_size2"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.25, easyhistogram_inputsFn["easyhistogram_back_button"]), Interact.pad(0.25, easyhistogram_inputsFn["easyhistogram_plot_button"])), style=Dict(:position => "absolute", :left => "650px")))

    Blink.body!(w, easyhistogram_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Histogram") ## Adding title to Blink window 'w'

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easyhistogram_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(EasyPlotting)[1:end-19], "Figures/Histogram/histogram_dataformat.png"))) ## When easyhistogram_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easyhistogram_back") do args...
        easymain() ## When easyhistogram_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easyhistogram_plot") do args... ## When easyhistogram_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            if (easyhistogram_inputsFn["easyhistogram_file"][]::String)[end-3:end] == "xlsx" ## If input file is .xlsx
                global df = DataFrames.DataFrame(XLSX.readtable((easyhistogram_inputsFn["easyhistogram_file"][]::String), (easyhistogram_inputsFn["easyhistogram_sheet"][]::String))...) ## Convert dataset to dataframe
            elseif (easyhistogram_inputsFn["easyhistogram_file"][]::String)[end-2:end] == "csv" ## If input file is .csv
                global df = DataFrames.DataFrame(CSV.read(easyhistogram_inputsFn["easyhistogram_file"][]::String)) ## Convert dataset to dataframe
            elseif (easyhistogram_inputsFn["easyhistogram_file"][]::String)[end-2:end] == "txt" ## If input file is .txt
                global df = DataFrames.DataFrame(DelimitedFiles.readdlm(easyhistogram_inputsFn["easyhistogram_file"][]::String, '\t')) ## Convert dataset to dataframe

                ## Renaming row 1 of df as column names since .txt files return the top row as row 1 instead of column names
                for i in 1:size(df, 2)
                    DataFrames.rename!(df, names(df)[i]=>Symbol(df[1,i]))
                end
                DataFrames.deleterows!(df, 1) ## Deleting row 1 of df
            end

            ## Plot histogram
            StatsPlots.plotlyjs() ## Using PLotlyJS backend
            if easyhistogram_inputsFn["easyhistogram_size1"][]::String == "" ## If no user-input for plot size
                if easyhistogram_inputsFn["easyhistogram_scale"][] == "None" ## For no logarithmic scaling
                    StatsPlots.histogram(collect(df[:,2]), xlabel = string(names(df)[2]), color=Symbol(easyhistogram_inputsFn["easyhistogram_colours"][]), legend=false)
                    StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                elseif easyhistogram_inputsFn["easyhistogram_scale"][] == "loge" ## For loge logarithmic scaling
                    StatsPlots.histogram(log.(collect(df[:,2])), xlabel = string(names(df)[2]), color=Symbol(easyhistogram_inputsFn["easyhistogram_colours"][]), legend=false)
                    StatsPlots.gui()
                elseif easyhistogram_inputsFn["easyhistogram_scale"][] == "log2" ## For log2 logarithmic scaling
                    StatsPlots.histogram(log2.(collect(df[:,2])), xlabel = string(names(df)[2]), color=Symbol(easyhistogram_inputsFn["easyhistogram_colours"][]), legend=false)
                    StatsPlots.gui()
                elseif easyhistogram_inputsFn["easyhistogram_scale"][] == "log10" ## For log10 logarithmic scaling
                    StatsPlots.histogram(log10.(collect(df[:,2])), xlabel = string(names(df)[2]), color=Symbol(easyhistogram_inputsFn["easyhistogram_colours"][]), legend=false)
                    StatsPlots.gui()
                end
            else ## If plot size is defined by user
                if easyhistogram_inputsFn["easyhistogram_scale"][] == "None" ## For no logarithmic scaling
                    StatsPlots.histogram(collect(df[:,2]), xlabel = string(names(df)[2]), color=Symbol(easyhistogram_inputsFn["easyhistogram_colours"][]), size=(parse(Float64, easyhistogram_inputsFn["easyhistogram_size1"][]), parse(Float64, easyhistogram_inputsFn["easyhistogram_size2"][])), legend=false)
                    StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                elseif easyhistogram_inputsFn["easyhistogram_scale"][] == "loge" ## For loge logarithmic scaling
                    StatsPlots.histogram(log.(collect(df[:,2])), xlabel = string(names(df)[2]), color=Symbol(easyhistogram_inputsFn["easyhistogram_colours"][]), size=(parse(Float64, easyhistogram_inputsFn["easyhistogram_size1"][]), parse(Float64, easyhistogram_inputsFn["easyhistogram_size2"][])), legend=false)
                    StatsPlots.gui()
                elseif easyhistogram_inputsFn["easyhistogram_scale"][] == "log2" ## For log2 logarithmic scaling
                    StatsPlots.histogram(log2.(collect(df[:,2])), xlabel = string(names(df)[2]), color=Symbol(easyhistogram_inputsFn["easyhistogram_colours"][]), size=(parse(Float64, easyhistogram_inputsFn["easyhistogram_size1"][]), parse(Float64, easyhistogram_inputsFn["easyhistogram_size2"][])), legend=false)
                    StatsPlots.gui()
                elseif easyhistogram_inputsFn["easyhistogram_scale"][] == "log10" ## For log10 logarithmic scaling
                    StatsPlots.histogram(log10.(collect(df[:,2])), xlabel = string(names(df)[2]), color=Symbol(easyhistogram_inputsFn["easyhistogram_colours"][]), size=(parse(Float64, easyhistogram_inputsFn["easyhistogram_size1"][]), parse(Float64, easyhistogram_inputsFn["easyhistogram_size2"][])), legend=false)
                    StatsPlots.gui()
                end
            end
        catch
            ## Alert if sheet name is not entered for excel .xlsx files
            if (easyhistogram_inputsFn["easyhistogram_file"][]::String)[end-3:end] == "xlsx" && easyhistogram_inputsFn["easyhistogram_sheet"][]::String == ""
                @js_ w alert("Excel .xlsx sheet name not entered. Kindly enter the sheet name and try again.")
            else
                @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
            end
        end
    end
end #function easyhistogram()

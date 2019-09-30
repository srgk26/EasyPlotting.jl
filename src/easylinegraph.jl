#### Main code for linegraph plot
function easylinegraph()
    w = Blink.Window() ## Opening new Blink Window

    ## Defining easylinegraph_input widgets for user inputs
    function easylinegraph_inputs()
        easylinegraph_file = Interact.filepicker(accept=[".xlsx", ".csv", ".txt"]) ## Restricting file input types to .xlsx/.csv/.txt
        easylinegraph_sheet = Interact.textbox("Excel sheet name") ## Need sheet name for .xlsx files
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
        Interact.Widget(["easylinegraph_file"=>easylinegraph_file, "easylinegraph_sheet"=>easylinegraph_sheet, "easylinegraph_dataformat_button"=>easylinegraph_dataformat_button, "easylinegraph_colours"=>easylinegraph_colours, "easylinegraph_scale"=>easylinegraph_scale, "easylinegraph_size1"=>easylinegraph_size1, "easylinegraph_size2"=>easylinegraph_size2, "easylinegraph_back_button"=>easylinegraph_back_button, "easylinegraph_plot_button"=>easylinegraph_plot_button]) ## Consolidating all widgets
    end
    easylinegraph_inputsFn = easylinegraph_inputs()

    easylinegraph_intro1 = "This section provides additional 'Line graph' specific configuration options that you could select below to further customise your Line graph."
    easylinegraph_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easylinegraph_intro3 = "Now please upload your dataset below and select options for Line graph:"

    ## Designing easylinegraph_page layout
    easylinegraph_page = Interact.node(:html,
                                style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                                Interact.node(:p, easylinegraph_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, easylinegraph_intro2), Interact.pad(0.25, easylinegraph_inputsFn["easylinegraph_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, easylinegraph_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "Upload data file - only .txt/.csv/.xlsx file extensions accepted:"), Interact.pad(0.25, easylinegraph_inputsFn["easylinegraph_file"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "If excel .xlsx file, pls also enter sheet name (case & space sensitive):"), Interact.pad(0.25, easylinegraph_inputsFn["easylinegraph_sheet"])), style=Dict(:color=>"#F4A460", :size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Line graph:"), Interact.pad(0.25, easylinegraph_inputsFn["easylinegraph_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easylinegraph_inputsFn["easylinegraph_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Enter plot size (numbers only):"), Interact.pad(0.25, easylinegraph_inputsFn["easylinegraph_size1"]), Interact.pad(0.25, easylinegraph_inputsFn["easylinegraph_size2"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.25, easylinegraph_inputsFn["easylinegraph_back_button"]), Interact.pad(0.25, easylinegraph_inputsFn["easylinegraph_plot_button"])), style=Dict(:position => "absolute", :left => "650px")))

    Blink.body!(w, easylinegraph_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Line graph") ## Adding title to Blink window 'w'

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easylinegraph_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(EasyPlotting)[1:end-19], "Figures/Linegraph/linegraph_dataformat.png"))) ## When easylinegraph_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easylinegraph_back") do args...
        easymain() ## When easylinegraph_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easylinegraph_plot") do args... ## When easylinegraph_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            if (easylinegraph_inputsFn["easylinegraph_file"][]::String)[end-3:end] == "xlsx" ## If input file is .xlsx
                global df = DataFrames.DataFrame(XLSX.readtable((easylinegraph_inputsFn["easylinegraph_file"][]::String), (easylinegraph_inputsFn["easylinegraph_sheet"][]::String))...) ## Convert dataset to dataframe
            elseif (easylinegraph_inputsFn["easylinegraph_file"][]::String)[end-2:end] == "csv" ## If input file is .csv
                global df = DataFrames.DataFrame(CSV.read(easylinegraph_inputsFn["easylinegraph_file"][]::String)) ## Convert dataset to dataframe
            elseif (easylinegraph_inputsFn["easylinegraph_file"][]::String)[end-2:end] == "txt" ## If input file is .txt
                global df = DataFrames.DataFrame(DelimitedFiles.readdlm(easylinegraph_inputsFn["easylinegraph_file"][]::String, '\t')) ## Convert dataset to dataframe

                ## Renaming row 1 of df as column names since .txt files return the top row as row 1 instead of column names
                for i in 1:size(df, 2)
                    DataFrames.rename!(df, names(df)[i]=>Symbol(df[1,i]))
                end
                DataFrames.deleterows!(df, 1) ## Deleting row 1 of df
            end 

            ## Plot linegraph
            StatsPlots.plotlyjs() ## Using PLotlyJS backend
            if easylinegraph_inputsFn["easylinegraph_size1"][]::String == "" ## If no user-input for plot size
                if easylinegraph_inputsFn["easylinegraph_scale"][] == "None" ## For no logarithmic scaling
                    StatsPlots.plot(convert(Matrix, df[:,2:end]), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputsFn["easylinegraph_colours"][]), legend=true)
                    StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                elseif easylinegraph_inputsFn["easylinegraph_scale"][] == "loge" ## For loge logarithmic scaling
                    StatsPlots.plot(log.(convert(Matrix, df[:,2:end])), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputsFn["easylinegraph_colours"][]), legend=true)
                    StatsPlots.gui()
                elseif easylinegraph_inputsFn["easylinegraph_scale"][] == "log2" ## For log2 logarithmic scaling
                    StatsPlots.plot(log2.(convert(Matrix, df[:,2:end])), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputsFn["easylinegraph_colours"][]), legend=true)
                    StatsPlots.gui()
                elseif easylinegraph_inputsFn["easylinegraph_scale"][] == "log10" ## For log10 logarithmic scaling
                    StatsPlots.plot(log10.(convert(Matrix, df[:,2:end])), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputsFn["easylinegraph_colours"][]), legend=true)
                    StatsPlots.gui()
                end
            else ## If plot size is defined by user
                if easylinegraph_inputsFn["easylinegraph_scale"][] == "None" ## For no logarithmic scaling
                    StatsPlots.plot(convert(Matrix, df[:,2:end]), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputsFn["easylinegraph_colours"][]), size=(parse(Float64, easylinegraph_inputsFn["easylinegraph_size1"][]), parse(Float64, easylinegraph_inputsFn["easylinegraph_size2"][])), legend=true)
                    StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                elseif easylinegraph_inputsFn["easylinegraph_scale"][] == "loge" ## For loge logarithmic scaling
                    StatsPlots.plot(log.(convert(Matrix, df[:,2:end])), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputsFn["easylinegraph_colours"][]), size=(parse(Float64, easylinegraph_inputsFn["easylinegraph_size1"][]), parse(Float64, easylinegraph_inputsFn["easylinegraph_size2"][])), legend=true)
                    StatsPlots.gui()
                elseif easylinegraph_inputsFn["easylinegraph_scale"][] == "log2" ## For log2 logarithmic scaling
                    StatsPlots.plot(log2.(convert(Matrix, df[:,2:end])), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputsFn["easylinegraph_colours"][]), size=(parse(Float64, easylinegraph_inputsFn["easylinegraph_size1"][]), parse(Float64, easylinegraph_inputsFn["easylinegraph_size2"][])), legend=true)
                    StatsPlots.gui()
                elseif easylinegraph_inputsFn["easylinegraph_scale"][] == "log10" ## For log10 logarithmic scaling
                    StatsPlots.plot(log10.(convert(Matrix, df[:,2:end])), marker = true, markersize = 4, label = [string(names(df)[i]) for i in 2:size(df,2)], color=Symbol(easylinegraph_inputsFn["easylinegraph_colours"][]), size=(parse(Float64, easylinegraph_inputsFn["easylinegraph_size1"][]), parse(Float64, easylinegraph_inputsFn["easylinegraph_size2"][])), legend=true)
                    StatsPlots.gui()
                end
            end
        catch
            ## Alert if sheet name is not entered for excel .xlsx files
            if (easylinegraph_inputsFn["easylinegraph_file"][]::String)[end-3:end] == "xlsx" && easylinegraph_inputsFn["easylinegraph_sheet"][]::String == ""
                @js_ w alert("Excel .xlsx sheet name not entered. Kindly enter the sheet name and try again.")
            else
                @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
            end
        end
    end
end #function easylinegraph()

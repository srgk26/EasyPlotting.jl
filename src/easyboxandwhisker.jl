#### Main code for boxandwhisker plot
function easyboxandwhisker()
    w = Blink.Window() ## Opening new Blink Window

    ## Defining easyboxandwhisker_input widgets for user inputs
    function easyboxandwhisker_inputs()
        easyboxandwhisker_file = Interact.filepicker(accept=[".xlsx", ".csv", ".txt"]) ## Restricting file input types to .xlsx/.csv/.txt
        easyboxandwhisker_sheet = Interact.textbox("Excel sheet name") ## Need sheet name for .xlsx files
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
        Interact.Widget(["easyboxandwhisker_file"=>easyboxandwhisker_file, "easyboxandwhisker_sheet"=>easyboxandwhisker_sheet, "easyboxandwhisker_dataformat_button"=>easyboxandwhisker_dataformat_button, "easyboxandwhisker_colours"=>easyboxandwhisker_colours, "easyboxandwhisker_scale"=>easyboxandwhisker_scale, "easyboxandwhisker_size1"=>easyboxandwhisker_size1, "easyboxandwhisker_size2"=>easyboxandwhisker_size2, "easyboxandwhisker_back_button"=>easyboxandwhisker_back_button, "easyboxandwhisker_plot_button"=>easyboxandwhisker_plot_button]) ## Consolidating all widgets
    end
    easyboxandwhisker_inputsFn = easyboxandwhisker_inputs()

    easyboxandwhisker_intro1 = "This section provides additional 'Box and Whisker' specific configuration options that you could select below to further customise your Box and Whisker plot."
    easyboxandwhisker_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easyboxandwhisker_intro3 = "Now please upload your dataset below and select options for Box and Whisker:"

    ## Designing easyboxandwhisker_page layout
    easyboxandwhisker_page = Interact.node(:html,
                                style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                                Interact.node(:p, easyboxandwhisker_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, easyboxandwhisker_intro2), Interact.pad(0.25, easyboxandwhisker_inputsFn["easyboxandwhisker_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, easyboxandwhisker_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "Upload data file - only .txt/.csv/.xlsx file extensions accepted:"), Interact.pad(0.25, easyboxandwhisker_inputsFn["easyboxandwhisker_file"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "If excel .xlsx file, pls also enter sheet name (case & space sensitive):"), Interact.pad(0.25, easyboxandwhisker_inputsFn["easyboxandwhisker_sheet"])), style=Dict(:color=>"#F4A460", :size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Box and Whisker plot:"), Interact.pad(0.25, easyboxandwhisker_inputsFn["easyboxandwhisker_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easyboxandwhisker_inputsFn["easyboxandwhisker_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Enter plot size (numbers only):"), Interact.pad(0.25, easyboxandwhisker_inputsFn["easyboxandwhisker_size1"]), Interact.pad(0.25, easyboxandwhisker_inputsFn["easyboxandwhisker_size2"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                                Interact.node(:p, Interact.hbox(Interact.pad(0.25, easyboxandwhisker_inputsFn["easyboxandwhisker_back_button"]), Interact.pad(0.25, easyboxandwhisker_inputsFn["easyboxandwhisker_plot_button"])), style=Dict(:position => "absolute", :left => "650px")))

    Blink.body!(w, easyboxandwhisker_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Box and Whisker") ## Adding title to Blink window 'w'

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easyboxandwhisker_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(EasyPlotting)[1:end-19], "Figures/BoxandWhisker/boxandwhisker_dataformat.png"))) ## When easyboxandwhisker_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easyboxandwhisker_back") do args...
        easymain() ## When easyboxandwhisker_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easyboxandwhisker_plot") do args... ## When easyboxandwhisker_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            if (easyboxandwhisker_inputsFn["easyboxandwhisker_file"][]::String)[end-3:end] == "xlsx" ## If input file is .xlsx
                global df = DataFrames.DataFrame(XLSX.readtable((easyboxandwhisker_inputsFn["easyboxandwhisker_file"][]::String), (easyboxandwhisker_inputsFn["easyboxandwhisker_sheet"][]::String))...) ## Convert dataset to dataframe
            elseif (easyboxandwhisker_inputsFn["easyboxandwhisker_file"][]::String)[end-2:end] == "csv" ## If input file is .csv
                global df = DataFrames.DataFrame(CSV.read(easyboxandwhisker_inputsFn["easyboxandwhisker_file"][]::String)) ## Convert dataset to dataframe
            elseif (easyboxandwhisker_inputsFn["easyboxandwhisker_file"][]::String)[end-2:end] == "txt" ## If input file is .txt
                global df = DataFrames.DataFrame(DelimitedFiles.readdlm(easyboxandwhisker_inputsFn["easyboxandwhisker_file"][]::String, '\t')) ## Convert dataset to dataframe

                ## Renaming row 1 of df as column names since .txt files return the top row as row 1 instead of column names
                for i in 1:size(df, 2)
                    DataFrames.rename!(df, names(df)[i]=>Symbol(df[1,i]))
                end
                DataFrames.deleterows!(df, 1) ## Deleting row 1 of df
            end

            ## Plot boxandwhisker
            StatsPlots.plotlyjs() ## Using PLotlyJS backend
            if easyboxandwhisker_inputsFn["easyboxandwhisker_size1"][]::String == "" ## If no user-input for plot size
                if easyboxandwhisker_inputsFn["easyboxandwhisker_scale"][] == "None" ## For no logarithmic scaling
                    StatsPlots.boxplot(convert(Array{Float64,2}, df[:,2:end]), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputsFn["easyboxandwhisker_colours"][]), legend=false) ## Converting to 'Array{Float64,2}' instead of the type unspecified 'Matrix' as 'Matrix' gives errors for boxplot
                    StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                elseif easyboxandwhisker_inputsFn["easyboxandwhisker_scale"][] == "loge" ## For loge logarithmic scaling
                    StatsPlots.boxplot(log.(convert(Array{Float64,2}, df[:,2:end])), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputsFn["easyboxandwhisker_colours"][]), legend=false)
                    StatsPlots.gui()
                elseif easyboxandwhisker_inputsFn["easyboxandwhisker_scale"][] == "log2" ## For log2 logarithmic scaling
                    StatsPlots.boxplot(log2.(convert(Array{Float64,2}, df[:,2:end])), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputsFn["easyboxandwhisker_colours"][]), legend=false)
                    StatsPlots.gui()
                elseif easyboxandwhisker_inputsFn["easyboxandwhisker_scale"][] == "log10" ## For log10 logarithmic scaling
                    StatsPlots.boxplot(log10.(convert(Array{Float64,2}, df[:,2:end])), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputsFn["easyboxandwhisker_colours"][]), legend=false)
                    StatsPlots.gui()
                end
            else ## If plot size is defined by user
                if easyboxandwhisker_inputsFn["easyboxandwhisker_scale"][] == "None" ## For no logarithmic scaling
                    StatsPlots.boxplot(convert(Array{Float64,2}, df[:,2:end]), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputsFn["easyboxandwhisker_colours"][]), size=(parse(Float64, easyboxandwhisker_inputsFn["easyboxandwhisker_size1"][]), parse(Float64, easyboxandwhisker_inputsFn["easyboxandwhisker_size2"][])), legend=false)
                    StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                elseif easyboxandwhisker_inputsFn["easyboxandwhisker_scale"][] == "loge" ## For loge logarithmic scaling
                    StatsPlots.boxplot(log.(convert(Array{Float64,2}, df[:,2:end])), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputsFn["easyboxandwhisker_colours"][]), size=(parse(Float64, easyboxandwhisker_inputsFn["easyboxandwhisker_size1"][]), parse(Float64, easyboxandwhisker_inputsFn["easyboxandwhisker_size2"][])), legend=false)
                    StatsPlots.gui()
                elseif easyboxandwhisker_inputsFn["easyboxandwhisker_scale"][] == "log2" ## For log2 logarithmic scaling
                    StatsPlots.boxplot(log2.(convert(Array{Float64,2}, df[:,2:end])), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputsFn["easyboxandwhisker_colours"][]), size=(parse(Float64, easyboxandwhisker_inputsFn["easyboxandwhisker_size1"][]), parse(Float64, easyboxandwhisker_inputsFn["easyboxandwhisker_size2"][])), legend=false)
                    StatsPlots.gui()
                elseif easyboxandwhisker_inputsFn["easyboxandwhisker_scale"][] == "log10" ## For log10 logarithmic scaling
                    StatsPlots.boxplot(log10.(convert(Array{Float64,2}, df[:,2:end])), xticks = (1:size(df[:,2:end],2), [string(names(df)[i]) for i in 2:size(df,2)]), color=Symbol(easyboxandwhisker_inputsFn["easyboxandwhisker_colours"][]), size=(parse(Float64, easyboxandwhisker_inputsFn["easyboxandwhisker_size1"][]), parse(Float64, easyboxandwhisker_inputsFn["easyboxandwhisker_size2"][])), legend=false)
                    StatsPlots.gui()
                end
            end
        catch
            ## Alert if sheet name is not entered for excel .xlsx files
            if (easyboxandwhisker_inputsFn["easyboxandwhisker_file"][]::String)[end-3:end] == "xlsx" && easyboxandwhisker_inputsFn["easyboxandwhisker_sheet"][]::String == ""
                @js_ w alert("Excel .xlsx sheet name not entered. Kindly enter the sheet name and try again.")
            else
                @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
            end
        end
    end
end #function easyboxandwhisker()

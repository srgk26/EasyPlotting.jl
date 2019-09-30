#### Main code for barchart plot
function easybarchart()
    w = Blink.Window() ## Opening new Blink Window

    ## Defining easybarchart_input widgets for user inputs
    function easybarchart_inputs()
        easybarchart_file = Interact.filepicker(accept=[".xlsx", ".csv", ".txt"]) ## Restricting file input types to .xlsx/.csv/.txt
        easybarchart_sheet = Interact.textbox("Excel sheet name") ## Need sheet name for .xlsx files
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
        Interact.Widget(["easybarchart_file"=>easybarchart_file, "easybarchart_sheet"=>easybarchart_sheet, "easybarchart_dataformat_button"=>easybarchart_dataformat_button, "easybarchart_colours"=>easybarchart_colours, "easybarchart_scale"=>easybarchart_scale, "easybarchart_size1"=>easybarchart_size1, "easybarchart_size2"=>easybarchart_size2, "easybarchart_back_button"=>easybarchart_back_button, "easybarchart_plot_button"=>easybarchart_plot_button]) ## Consolidating all widgets
    end
    easybarchart_inputsFn = easybarchart_inputs()

    easybarchart_intro1 = "This section provides additional 'Bar Chart' specific configuration options that you could select below to further customise your Bar Chart."
    easybarchart_intro2 = "Please also ensure your input dataset is of the correct format. Click here for more:"
    easybarchart_intro3 = "Now please upload your dataset below and select options for Bar Chart:"

    ## Designing easybarchart_page layout
    easybarchart_page = Interact.node(:html,
                            style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                            Interact.node(:p, easybarchart_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, easybarchart_intro2), Interact.pad(0.25, easybarchart_inputsFn["easybarchart_dataformat_button"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, easybarchart_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "Upload data file - only .txt/.csv/.xlsx file extensions accepted:"), Interact.pad(0.25, easybarchart_inputsFn["easybarchart_file"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "If excel .xlsx file, pls also enter sheet name (case & space sensitive):"), Interact.pad(0.25, easybarchart_inputsFn["easybarchart_sheet"])), style=Dict(:color=>"#F4A460", :size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select fill colour palette for Bar Chart:"), Interact.pad(0.25, easybarchart_inputsFn["easybarchart_colours"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Select logarithmic scaling options:"), Interact.pad(0.25, easybarchart_inputsFn["easybarchart_scale"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.5, "(Optional) Enter plot size (numbers only):"), Interact.pad(0.25, easybarchart_inputsFn["easybarchart_size1"]), Interact.pad(0.25, easybarchart_inputsFn["easybarchart_size2"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                            Interact.node(:p, Interact.hbox(Interact.pad(0.25, easybarchart_inputsFn["easybarchart_back_button"]), Interact.pad(0.25, easybarchart_inputsFn["easybarchart_plot_button"])), style=Dict(:position => "absolute", :left => "650px")))

    Blink.body!(w, easybarchart_page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Bar Chart") ## Adding title to Blink window 'w'

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "easybarchart_dataformat") do args...
        ImageView.imshow(FileIO.load(joinpath(pathof(EasyPlotting)[1:end-19], "Figures/Barchart/barchart_dataformat.png"))) ## When easybarchart_dataformat_button is pressed, picture of user input data format pops up.
    end

    Blink.handle(w, "easybarchart_back") do args...
        easymain() ## When easybarchart_back_button is pressed, easymain() is executed.
    end

    Blink.handle(w, "easybarchart_plot") do args... ## When easybarchart_plot_button is pressed, the following arguments are executed
        try ## Implementing try/catch block
            if (easybarchart_inputsFn["easybarchart_file"][]::String)[end-3:end] == "xlsx" ## If input file is .xlsx
                global df = DataFrames.DataFrame(XLSX.readtable((easybarchart_inputsFn["easybarchart_file"][]::String), (easybarchart_inputsFn["easybarchart_sheet"][]::String))...) ## Convert dataset to dataframe
            elseif (easybarchart_inputsFn["easybarchart_file"][]::String)[end-2:end] == "csv" ## If input file is .csv
                global df = DataFrames.DataFrame(CSV.read(easybarchart_inputsFn["easybarchart_file"][]::String)) ## Convert dataset to dataframe
            elseif (easybarchart_inputsFn["easybarchart_file"][]::String)[end-2:end] == "txt" ## If input file is .txt
                global df = DataFrames.DataFrame(DelimitedFiles.readdlm(easybarchart_inputsFn["easybarchart_file"][]::String, '\t')) ## Convert dataset to dataframe

                ## Renaming row 1 of df as column names since .txt files return the top row as row 1 instead of column names
                for i in 1:size(df, 2)
                    DataFrames.rename!(df, names(df)[i]=>Symbol(df[1,i]))
                end
                DataFrames.deleterows!(df, 1) ## Deleting row 1 of df
            end

            ## Plot barchart
            StatsPlots.plotlyjs() ## Using PLotlyJS backend
            if easybarchart_inputsFn["easybarchart_size1"][]::String == "" ## If no user-input for plot size
                if easybarchart_inputsFn["easybarchart_scale"][] == "None" ## For no logarithmic scaling
                    StatsPlots.bar(collect(df[:,2]), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputsFn["easybarchart_colours"][]), legend=false)
                    StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                elseif easybarchart_inputsFn["easybarchart_scale"][] == "loge" ## For loge logarithmic scaling
                    StatsPlots.bar(log.(collect(df[:,2])), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputsFn["easybarchart_colours"][]), legend=false)
                    StatsPlots.gui()
                elseif easybarchart_inputsFn["easybarchart_scale"][] == "log2" ## For log2 logarithmic scaling
                    StatsPlots.bar(log2.(collect(df[:,2])), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputsFn["easybarchart_colours"][]), legend=false)
                    StatsPlots.gui()
                elseif easybarchart_inputsFn["easybarchart_scale"][] == "log10" ## For log10 logarithmic scaling
                    StatsPlots.bar(log10.(collect(df[:,2])), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputsFn["easybarchart_colours"][]), legend=false)
                    StatsPlots.gui()
                end
            else ## If plot size is defined by user
                if easybarchart_inputsFn["easybarchart_scale"][] == "None" ## For no logarithmic scaling
                    StatsPlots.bar(collect(df[:,2]), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputsFn["easybarchart_colours"][]), size=(parse(Float64, easybarchart_inputsFn["easybarchart_size1"][]), parse(Float64, easybarchart_inputsFn["easybarchart_size2"][])), legend=false)
                    StatsPlots.gui() ## Launches PlotlyJS interactive window to interact with plot and save figure
                elseif easybarchart_inputsFn["easybarchart_scale"][] == "loge" ## For loge logarithmic scaling
                    StatsPlots.bar(log.(collect(df[:,2])), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputsFn["easybarchart_colours"][]), size=(parse(Float64, easybarchart_inputsFn["easybarchart_size1"][]), parse(Float64, easybarchart_inputsFn["easybarchart_size2"][])), legend=false)
                    StatsPlots.gui()
                elseif easybarchart_inputsFn["easybarchart_scale"][] == "log2" ## For log2 logarithmic scaling
                    StatsPlots.bar(log2.(collect(df[:,2])), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputsFn["easybarchart_colours"][]), size=(parse(Float64, easybarchart_inputsFn["easybarchart_size1"][]), parse(Float64, easybarchart_inputsFn["easybarchart_size2"][])), legend=false)
                    StatsPlots.gui()
                elseif easybarchart_inputsFn["easybarchart_scale"][] == "log10" ## For log10 logarithmic scaling
                    StatsPlots.bar(log10.(collect(df[:,2])), xlabel = string(names(df)[2]), xticks = (1:length(df[:,1]), df[:,1]), color=Symbol(easybarchart_inputsFn["easybarchart_colours"][]), size=(parse(Float64, easybarchart_inputsFn["easybarchart_size1"][]), parse(Float64, easybarchart_inputsFn["easybarchart_size2"][])), legend=false)
                    StatsPlots.gui()
                end
            end
        catch
            ## Alert if sheet name is not entered for excel .xlsx files
            if (easybarchart_inputsFn["easybarchart_file"][]::String)[end-3:end] == "xlsx" && easybarchart_inputsFn["easybarchart_sheet"][]::String == ""
                @js_ w alert("Excel .xlsx sheet name not entered. Kindly enter the sheet name and try again.")
            else
                @js_ w alert("Oops! Something had gone wrong. Could it be that your user input dataset is of the wrong format?")
            end
        end
    end
end #function easybarchart()

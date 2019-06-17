function easymain()
    w = Blink.Window() ## Opening Blink Window

    ## Defining mainpage_input widgets for user inputs
    function mainpage_inputs()
        file = Interact.filepicker(accept=[".xlsx", ".csv", ".txt"]) ## Restricting file input types to .xlsx/.csv/.txt
        sheet = Interact.textbox("Excel sheet name") ## Need sheet name for .xlsx files
        plot_type = Interact.dropdown(["Heatmap", "Scatterplot", "Line graph", "Histogram", "Bar chart", "Box and Whisker", "Pie chart", "Violin plot"]) ## Creating dropdown menu for user to choose plot type
        mainpage_next_button = html"""<button onclick='Blink.msg("mainpage_next", "foo")'>Next</button>""" ## Configuring button on-click event to proceed to the next page
        Interact.Widget(["file"=>file, "sheet"=>sheet, "plot_type"=>plot_type, "mainpage_next_button"=>mainpage_next_button]) ## Consolidating all widgets
    end

    mainpage_intro1 = "This GUI serves to ease the process of producing high quality plots normally produced by coding. This GUI takes care of the coding involved in the background while you need only input your data, select relevant options, and produce as many plots as you would like, all with just a few clicks."
    mainpage_intro2 = "This GUI is designed primarily for quick data exploratory purposes, though you are very welcome to include these plots in your publications as well."
    mainpage_intro3 = "To start, simply upload your dataset below and select plot type. Click 'Next' to proceed."

    ## Designing main page layout
    mainpage = Interact.node(:html,
                style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                Interact.node(:p, mainpage_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                Interact.node(:p, mainpage_intro2, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                Interact.node(:p, mainpage_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "Upload data file - only .txt/.csv/.xlsx file extensions accepted:"), Interact.pad(0.25, mainpage_inputs()["file"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "If excel .xlsx file, pls also enter sheet name (case & space sensitive):"), Interact.pad(0.25, mainpage_inputs()["sheet"])), style=Dict(:color=>"#F4A460", :size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "Please select plot type:"), Interact.pad(0.25, mainpage_inputs()["plot_type"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                Interact.node(:p, mainpage_inputs()["mainpage_next_button"], style=Dict(:position => "absolute", :left => "720px")))

    Blink.body!(w, mainpage) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Welcome to easyplotting!") ## Adding title to Blink window 'w'

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "mainpage_next") do args...  ## When mainpage_next_button is pressed, the following arguments are executed
        if (mainpage_inputs()["file"][]::String)[end-3:end] == "xlsx" ## If input file is .xlsx
            df = DataFrames.DataFrame(XLSX.readtable((mainpage_inputs()["file"][]::String), (mainpage_inputs()["sheet"][]::String))...) ## Convert dataset to dataframe
        elseif (mainpage_inputs()["file"][]::String)[end-2:end] == "csv" ## If input file is .csv
            df = DataFrames.DataFrame(CSV.read(mainpage_inputs()["file"][]::String))
        elseif (mainpage_inputs()["file"][]::String)[end-2:end] == "txt" ## If input file is .txt
            df = DataFrames.DataFrame(DelimitedFiles.readdlm(mainpage_inputs()["file"][]::String, '\t'))
            ## Renaming row 1 of df as column names since .txt files return the top row as row 1 instead of column names
            for i in 1:size(df, 2)
                DataFrames.rename!(df, names(df)[i]=>Symbol(df[1,i]))
            end
            DataFrames.deleterows!(df, 1) ## Deleting row 1 of df
        end

        ## Invoke functions corresponding to plot type selected by user
        if mainpage_inputs()["plot_type"][] == "Heatmap"
            easyheatmap() ## When mainpage_next_button is pressed, easyheatmap() is executed.
        elseif mainpage_inputs()["plot_type"][] == "Scatterplot"
            easyscatterplot() ## When mainpage_next_button is pressed, easyheatmap() is executed.
        elseif mainpage_inputs()["plot_type"][] == "Line graph"
            easylinegraph() ## When mainpage_next_button is pressed, easyheatmap() is executed.
        elseif mainpage_inputs()["plot_type"][] == "Histogram"
            easyhistogram() ## When mainpage_next_button is pressed, easyheatmap() is executed.
        elseif mainpage_inputs()["plot_type"][] == "Bar chart"
            easybarchart() ## When mainpage_next_button is pressed, easyheatmap() is executed.
        elseif mainpage_inputs()["plot_type"][] == "Box and Whisker"
            easyboxandwhisker() ## When mainpage_next_button is pressed, easyheatmap() is executed.
        elseif mainpage_inputs()["plot_type"][] == "Pie chart"
            easypiechart() ## When mainpage_next_button is pressed, easyheatmap() is executed.
        elseif mainpage_inputs()["plot_type"][] == "Violin plot"
            easyviolinplot() ## When mainpage_next_button is pressed, easyheatmap() is executed.
        end

        ## Alert if sheet name is not entered for excel .xlsx files
        if (mainpage_inputs()["file"][]::String)[end-3:end] == "xlsx" && mainpage_inputs()["sheet"][]::String == ""
            @js_ w alert("Excel .xlsx sheet name not entered. Kindly enter the sheet name and try again.")
        end
    end
end #function easymain()

function easymain()
    w = Blink.Window() ## Opening Blink Window

    ## Defining mainpage_input widgets for user inputs
    function mainpage_inputs()
        plot_type = Interact.dropdown(["Bar chart", "Box and Whisker", "Heatmap", "Histogram", "Line graph", "Pie chart", "Scatterplot 2D", "Scatterplot 3D", "Stripplot", "Violin plot"]) ## Creating dropdown menu for user to choose plot type
        mainpage_next_button = html"""<button onclick='Blink.msg("mainpage_next", "foo")'>Next</button>""" ## Configuring button on-click event to proceed to the next page
        Interact.Widget(["plot_type"=>plot_type, "mainpage_next_button"=>mainpage_next_button]) ## Consolidating all widgets
    end
    mainpage_inputsFn = mainpage_inputs()

    mainpage_intro1 = "This GUI serves to ease the process of producing high quality plots normally produced by coding. This GUI takes care of the coding involved in the background while you need only input your data, select relevant options, and produce as many plots as you would like, all with just a few clicks."
    mainpage_intro2 = "This GUI is designed primarily for quick data exploratory purposes, though you are very welcome to include these plots in your publications as well."
    mainpage_intro3 = "To start, simply select plot type below and click 'Next' to proceed."

    ## Designing main page layout
    mainpage = Interact.node(:html,
                style=Dict(:backgroundColor => "#efefef", :boxShadow => "0px 0px 12px rgba(0,0,0,0.15)", :margin => "0 0 2em 0"),
                Interact.node(:p, mainpage_intro1, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                Interact.node(:p, mainpage_intro2, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                Interact.node(:p, mainpage_intro3, style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                Interact.node(:p, Interact.hbox(Interact.pad(0.5, "Please select plot type:"), Interact.pad(0.25, mainpage_inputsFn["plot_type"])), style=Dict(:size=>"30", :padding=>"2px", :margin => "0 0 1em 0")),
                Interact.node(:p, mainpage_inputsFn["mainpage_next_button"], style=Dict(:position => "absolute", :left => "720px")))

    Blink.body!(w, mainpage) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Welcome to easyplotting!") ## Adding title to Blink window 'w'

    ## This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "mainpage_next") do args...  ## When mainpage_next_button is pressed, the following arguments are executed
        ## Invoke functions corresponding to plot type selected by user when mainpage_next_button is pressed
        if mainpage_inputsFn["plot_type"][] == "Bar chart"
            easybarchart()
        elseif mainpage_inputsFn["plot_type"][] == "Box and Whisker"
            easyboxandwhisker()
        elseif mainpage_inputsFn["plot_type"][] == "Heatmap"
            easyheatmap()
        elseif mainpage_inputsFn["plot_type"][] == "Histogram"
            easyhistogram()
        elseif mainpage_inputsFn["plot_type"][] == "Line graph"
            easylinegraph()
        elseif mainpage_inputsFn["plot_type"][] == "Pie chart"
            easypiechart()
        elseif mainpage_inputsFn["plot_type"][] == "Scatterplot 2D"
            easyscatterplot2d()
        elseif mainpage_inputsFn["plot_type"][] == "Scatterplot 3D"
            easyscatterplot3d()
        elseif mainpage_inputsFn["plot_type"][] == "Stripplot"
            easystripplot()
        elseif mainpage_inputsFn["plot_type"][] == "Violin plot"
            easyviolinplot()
        end
    end
end #function easymain()

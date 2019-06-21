# easyplotting.jl
Graphical/statistical plotting GUI package for quick data visualisation and exploration. ***NO CODING REQUIRED***

This is an attempt to create a working GUI that serves to ease the process of producing high quality plots normally produced by coding. This GUI takes care of the coding involved in the background while you need only input your data, select relevant options, and produce as many plots as you would like, all with just a few clicks.

This is a preview of the main page of the GUI:

![Alt text](/Figures/mainpage_GUI.png?raw=true "Mainpage GUI")

Kindly take note that this GUI is designed primarily for quick data exploratory purposes providing only the basic, fundamental user customisation options, though you are very welcome to include these plots in your publications as well should they be deemed satisfactory.

If anyone would like to contribute, please feel free to submit a pull request. If any issues, please also feel free to open an issue. If particular plotting types or custom options are requested to be added, please open an issue as well.

***

## Format of data:

It is very important that your dataset is in accordance with the appropriate formats corresponding to the plot type. Click on the relevant links below for more on the formats, as well as relevant sample figures for how the plots would look like:

*Note: The data used to generate these figures are randomly generated. Therefore they may not appear to be a typical plot resembling that based on a real dataset.*

* Bar Chart: [format of dataset](/Figures/Barchart/barchart_dataformat.png) and [sample figure](/Figures/Barchart/barchart_sampleimage.png)
* Box and Whisker: [format of dataset](/Figures/BoxandWhisker/boxandwhisker_dataformat.png) and [sample figure](/Figures/BoxandWhisker/boxandwhisker_sampleimage.png)
* Heatmap: [format of dataset](/Figures/Heatmap/heatmap_dataformat.png) and [sample figure](/Figures/Heatmap/heatmap_sampleimage.png)
* Histogram: [format of dataset](/Figures/Histogram/histogram_dataformat.png) and [sample figure](/Figures/Histogram/histogram_sampleimage.png)
* Line graph: [format of dataset](/Figures/Linegraph/linegraph_dataformat.png) and [sample figure](/Figures/Linegraph/linegraph_sampleimage.png)
* Pie Chart: [format of dataset](/Figures/Piechart/piechart_dataformat.png) and [sample figure](/Figures/Piechart/piechart_sampleimage.png)
* Scatterplot 2D: [format of dataset](/Figures/Scatterplot2d/scatterplot2d_dataformat.png) and [sample figure](/Figures/Scatterplot2d/scatterplot2d_sampleimage.png)
* Scatterplot 3D: [format of dataset](/Figures/Scatterplot3d/scatterplot3d_dataformat.png) and [sample figure](/Figures/Scatterplot3d/scatterplot3d_sampleimage.png)
* Stripplot: [format of dataset](/Figures/Stripplot/stripplot_dataformat.png) and [sample figure](/Figures/Stripplot/stripplot_sampleimage.png)
* Violinplot: [format of dataset](/Figures/Violinplot/violinplot_dataformat.png) and [sample figure](/Figures/Violinplot/violinplot_sampleimage.png)

Files of type .xlsx/.csv/.txt(tab-delimited) extensions are supported.

***

## Usage:

1. Download and install Julia from https://julialang.org/downloads/ (or for Linux, with your respective package managers).
2. Open the Julia app, copy and paste at the prompt:

```
if haskey(Pkg.installed(), "easyplotting") == false
    using Pkg; Pkg.add("https://github.com/srgk26/easyplotting.jl.git")
end
using easyplotting; retry(easyplotting.easymain::Function, delays=ExponentialBackOff(n=5, first_delay=5, max_delay=10))() ## Retry function in case of an IOError when launching Blink
```

Press enter. If this is your first time using this package, it would take about 20 min for the installation process.

***Updating easyplotting.jl***

There will be regular updates to this easyplotting.jl package. If you already have easyplotting installed in your system, simply copy and paste:

```
using Pkg; Pkg.update("easyplotting")
```

This fetches the latest updates into your local system. 

***

## Credits:

Credits to the developers of the Julia language and libraries. Special thanks to [Dustin T Irwin](https://github.com/dustyirwin) for his script on [Stackoverflow](https://stackoverflow.com/questions/52845964/how-to-use-handlew-flag-with-julia-webio-blink), which helped greatly for the main structure of my code.

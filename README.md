# easyplotting.jl
Graphical/statistical plotting GUI package for quick data visualisation and exploration. ***NO CODING REQUIRED***

This is an attempt to create a working GUI that serves to ease the process of producing high quality plots normally produced by coding. This GUI takes care of the coding involved in the background while you need only input your data, select relevant options, and produce as many plots as you would like, all with just a few clicks.

Kindly take note that this GUI is designed primarily for quick data exploratory purposes providing only the basic, fundamental user customisation options, though you are very welcome to include these plots in your publications as well should they be deemed satisfactory.

If anyone would like to contribute, please feel free to submit a pull request. If any issues, please also feel free to open an issue. If particular plotting types are requested to be added into the app, please open an issue as well.

***

## Format of data:

It is very important that your dataset is in accordance with the appropriate formats corresponding to the plot type. Click on the relevant links below for more on the formats, as well as relevant sample figures for how the plots would look like:

*Note: The data used to generate these figures are randomly generated. Therefore they may not appear to be a typical plot resembling that based on a real dataset.*

* Heatmap: [format of dataset](https://github.com/srgk26/easyplotting.jl/tree/master/src/Heatmap/Heatmap_dataformat.png) and [sample figure](https://github.com/srgk26/easyplotting.jl/tree/master/src/Heatmap/Heatmap_sampleimage.png)
* Scatterplot: [format of dataset](https://github.com/srgk26/easyplotting.jl/tree/master/src/Scatterplot/Scatterplot_dataformat.png) and [sample figure](https://github.com/srgk26/easyplotting.jl/tree/master/src/Scatterplot/Scatterplot_sampleimage.png)
* Line graph: [format of dataset](https://github.com/srgk26/easyplotting.jl/tree/master/src/Linegraph/Linegraph_dataformat.png) and [sample figure](https://github.com/srgk26/easyplotting.jl/tree/master/src/Linegraph/Linegraph_sampleimage.png)
* Histogram: [format of dataset](https://github.com/srgk26/easyplotting.jl/tree/master/src/Histogram/Histogram_dataformat.png) and [sample figure](https://github.com/srgk26/easyplotting.jl/tree/master/src/Histogram/Histogram_sampleimage.png)
* Bar chart: [format of dataset](https://github.com/srgk26/easyplotting.jl/tree/master/src/Barchart/Barchart_dataformat.png) and [sample figure](https://github.com/srgk26/easyplotting.jl/tree/master/src/Barchart/Barchart_sampleimage.png)
* Box and Whisker: [format of dataset](https://github.com/srgk26/easyplotting.jl/tree/master/src/BoxandWhisker/BoxandWhisker_dataformat.png) and [sample figure](https://github.com/srgk26/easyplotting.jl/tree/master/src/BoxandWhisker/BoxandWhisker_sampleimage.png)
* Pie chart: [format of dataset](https://github.com/srgk26/easyplotting.jl/tree/master/src/Piechart/Piechart_dataformat.png) and [sample figure](https://github.com/srgk26/easyplotting.jl/tree/master/src/Piechart/Piechart_sampleimage.png)
* Violin plot: [format of dataset](https://github.com/srgk26/easyplotting.jl/tree/master/src/Violinplot/Violinplot_dataformat.png) and [sample figure](https://github.com/srgk26/easyplotting.jl/tree/master/src/Violinplot/Violinplot_sampleimage.png)

Files of type .xlsx/.csv/.txt(tab-delimited) extensions are supported.

***

## Usage:

1. Download and install Julia from https://julialang.org/downloads/ (or for Linux, with your respective package managers).
2. Open the Julia app, copy and paste at the prompt:

```
using Pkg; if haskey(Pkg.installed(), "easyplotting") == false
    Pkg.add("https://github.com/srgk26/easyplotting.jl.git")
end
using easyplotting; easyplotting.easymain()
```

Press enter. If this is your first time using this package, it would take about 10 min for the installation process.

***

## Credits:

Credits to the developers of the Julia language and libraries. Special thanks to `@Dustin T Irwin`@https://github.com/dustyirwin for his script on Stackoverflow: https://stackoverflow.com/questions/52845964/how-to-use-handlew-flag-with-julia-webio-blink, which helped greatly for the main structure of my code.

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

1. Download and install Julia from https://julialang.org/downloads/ (Linux users, see below!).
2. Open the Julia app, copy and paste at the prompt:

```
using Pkg
if haskey(Pkg.installed(), "easyplotting") == false
    Pkg.add(PackageSpec(url="https://github.com/JuliaGraphics/Gtk.jl.git")); Pkg.add(PackageSpec(url="https://github.com/sglyon/PlotlyJS.jl.git")); Pkg.add(PackageSpec(url="https://github.com/sglyon/ORCA.jl.git")); Pkg.add(PackageSpec(url="https://github.com/JuliaIO/ImageMagick.jl.git")) ## Pre-installing dependencies manually due to non-detection of these pkgs in path
    Pkg.add(PackageSpec(url="https://github.com/srgk26/easyplotting.jl.git")) ## Install easyplotting.jl package
end
using easyplotting; retry(easyplotting.easymain::Function, delays=ExponentialBackOff(n=5, first_delay=5, max_delay=10))() ## Retry function in case of an IOError when launching Blink
```

Press enter. If this is your first time using this package, it could 15-20 min for the full installation process.

Also, kindly note that it may take a while for the plot to load after clicking the 'Plot' button, sometimes up to 2 min.

If you have already installed this easyplotting.jl package, you may prefer to launch the GUI by copying and pasting this instead at the Julia prompt:

```
using easyplotting; retry(easyplotting.easymain::Function, delays=ExponentialBackOff(n=5, first_delay=5, max_delay=10))() 
```

***Updating easyplotting.jl***

There will be regular updates to this easyplotting.jl package. If you already have easyplotting installed in your system, simply copy and paste:

```
using Pkg; Pkg.update("easyplotting"); Pkg.build("easyplotting")
```

This fetches the latest updates into your local system. Then simply use the package as per normal.

***Linux usage***

Linux users, please refrain from installing Julia with your respective package managers. Julia compiled from source produces build error (for the 'Arpack' dependency) when building this easyplotting.jl package, which affects other downstream processes. Instead:

1. Install the 'Generic Linux Binaries for x86' official package.
2. Create a symbolic link of the downloaded julia binary inside the `/usr/local/bin` folder. Assuming you have extracted the Tarballs into your home folder (i.e. `$HOME`), copy and paste in the terminal:

```
sudo ln -s ~/julia-1.1.1/bin/julia /usr/local/bin/julia
```

Replace 'julia-1.1.1' with the respective folder name. Then run Julia by simply typing `julia` in the terminal. [Click here](https://julialang.org/downloads/platform.html) for more information.

If you are using wayland as your display server protocol, after the easyplotting installation process, you would also need to type this on your bash shell to switch the qt5 plotting platform to wayland: `QT_QPA_PLATFORM=wayland`.

You would also need to have a gtk package installed on your system with your respective package manager:

* For Arch Linux based distributions, do `sudo pacman -S gtk3`.<br>
* For Debian based distributions, do `sudo apt install libgtk-3-dev`.<br>
* For Fedora/RHEL/CentOS distributions, kindly refer to: https://pkgs.org/download/devel%28libgtk-3%29.

As an example, for Julia-1.1.1 running Arch Linux using wayland as display server:

```
[srgk26@ArchLinux ~]$ wget https://julialang-s3.julialang.org/bin/linux/x64/1.1/julia-1.1.1-linux-x86_64.tar.gz
[srgk26@ArchLinux ~]$ tar -xvzf julia-1.1.1-linux-x86_64.tar.gz && rm julia-1.1.1-linux-x86_64.tar.gz
[srgk26@ArchLinux ~]$ sudo ln -s ~/julia-1.1.1/bin/julia /usr/local/bin/julia
[srgk26@ArchLinux ~]$ QT_QPA_PLATFORM=wayland ## Only if you're using Wayland
[srgk26@ArchLinux ~]$ sudo pacman -S gtk3 ## Modify this to install gtk3 with your respective package manager
```

***

## Credits:

Credits to the developers of the Julia language and libraries. Special thanks to [Dustin T Irwin](https://github.com/dustyirwin) for his script on [Stackoverflow](https://stackoverflow.com/questions/52845964/how-to-use-handlew-flag-with-julia-webio-blink), which helped greatly for the main structure of my code.

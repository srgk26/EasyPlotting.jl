[![Build Status](https://travis-ci.org/srgk26/EasyPlotting.jl.svg?branch=master)](https://travis-ci.org/srgk26/EasyPlotting.jl)
[![codecov](https://codecov.io/gh/srgk26/EasyPlotting.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/srgk26/EasyPlotting.jl)
[![Coverage Status](https://coveralls.io/repos/github/srgk26/EasyPlotting.jl/badge.png?branch=master)](https://coveralls.io/github/srgk26/EasyPlotting.jl?branch=master)
[![GitHub latest release](https://img.shields.io/badge/latest-v0.1.0-blue)](https://github.com/srgk26/EasyPlotting.jl)
[![GitHub latest release](https://img.shields.io/badge/stable-v0.1.0-green)](https://github.com/srgk26/EasyPlotting.jl/releases)
[![Julia versions](https://img.shields.io/badge/julia-1.2+-blue)](https://julialang.org/)
[![Code size](https://img.shields.io/github/languages/code-size/srgk26/EasyPlotting.jl)](https://github.com/srgk26/EasyPlotting.jl)
[![Repo size](https://img.shields.io/github/repo-size/srgk26/EasyPlotting.jl)](https://github.com/srgk26/EasyPlotting.jl)
[![Docker automatic build](https://img.shields.io/docker/cloud/automated/srgk26/easyplotting)](https://hub.docker.com/r/srgk26/easyplotting/tags)
[![Docker cloud build](https://img.shields.io/docker/cloud/build/srgk26/easyplotting)](https://hub.docker.com/r/srgk26/easyplotting/tags)

# EasyPlotting.jl
Graphical/statistical plotting GUI package for quick data visualisation and exploration. ***NO CODING REQUIRED***

This is a GUI that serves to ease the process of producing high quality plots normally produced by coding. This GUI takes care of the coding involved in the background while you need only input your data, select relevant options, and produce as many plots as you would like, all with just a few clicks.

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

## Windows and macOS Usage (Linux users, see below):

1. Download and install Julia from https://julialang.org/downloads/.
2. Open the Julia app, copy and paste at the prompt:

```
using Pkg; if haskey(Pkg.installed(), "EasyPlotting") == false; Pkg.add(["PlotlyJS", "ORCA", "ImageMagick", "EasyPlotting"]); end ## Re-installing dependencies manually due to non-detection of these pkgs installed from Manifest.toml in path
using EasyPlotting; retry(EasyPlotting.easymain::Function, delays=ExponentialBackOff(n=5, first_delay=5, max_delay=10))() ## Retry function in case of an IOError when launching Blink
```

Press enter. If this is your first time using this package, it could take 20-30 min for the full installation process.

***Kindly take note that pressing the 'Plot' button the first time may give an error. Kindly ignore the error message and try again, it will work from the second time.***

If you have already installed this EasyPlotting.jl package, you may prefer to launch the GUI by copying and pasting this instead at the Julia prompt:

```
using EasyPlotting; retry(EasyPlotting.easymain::Function, delays=ExponentialBackOff(n=5, first_delay=5, max_delay=10))() 
```

***Updating EasyPlotting.jl***

There will be regular updates to this EasyPlotting.jl package. If you already have EasyPlotting installed in your system, simply copy and paste:

```
using Pkg; Pkg.update("EasyPlotting"); Pkg.build("EasyPlotting")
```

This fetches the latest updates into your local system. Then simply use the package as per normal.

## Linux Usage:

Linux users, please refrain from installing Julia with your respective package managers. Julia compiled from source using your package manager produces build error (for the 'Arpack' dependency) when building this EasyPlotting.jl package, which affects other downstream processes. Instead:

1. Install the 'Generic Linux Binaries for x86' official package from https://julialang.org/downloads/.
2. Create a symbolic link of the downloaded julia binary inside the `/usr/local/bin` folder. Assuming you have extracted the Tarballs into your home folder (i.e. `$HOME`), copy and paste in the terminal:

```
sudo ln -s $HOME/julia-1.2.0/bin/julia /usr/local/bin/julia
```

Replace 'julia-1.2.0' with the respective folder name. [Click here](https://julialang.org/downloads/platform.html) for more information.

3. If you are using wayland as your display server protocol (the output of `echo $XDG_SESSION_TYPE` at the bash shell will tell you if it is wayland or x11), you would also need to set the qt5 plotting backend environment to wayland. Type this on your bash shell to switch the qt5 plotting platform to wayland system-wide: `sudo -- sh -c 'echo "export QT_QPA_PLATFORM=wayland" >> /etc/environment && source /etc/environment'`, or this to configure at user level: `echo "export QT_QPA_PLATFORM=wayland" >> ~/.bash_profile && source ~/.bash_profile`.

4. If not already installed, you would also need to have a gtk3 package installed on your system with your respective package manager:

* For Arch Linux based distributions, do `sudo pacman -S gtk3`.<br>
* For Debian based distributions, do `sudo apt install libgtk-3-dev`.<br>
* For Fedora and other yum based package managers, do `sudo dnf install gtk3`.<br>
* For RHEL/CentOS and other yum-based package managers, do `sudo yum install gtk3`.

5. You would also need the python3 seaborn package installed. Firstly, if not already installed, install 'pip3' (the python3 package manager) using your respective package manager:

* For Arch Linux based distributions, do `sudo pacman -S python-pip`.<br>
* For Debian based distributions, do `sudo apt install python3-pip`.<br>
* For Fedora and other yum based package managers, do `sudo dnf install python3-pip`.<br>
* For RHEL/CentOS and other yum-based package managers, do `sudo yum install python3-pip`.

To install seaborn, do either `sudo pip3 install seaborn` to install system-wide or `python3 -m pip install --user seaborn` to install at user level.

6. Then run Julia by simply typing `julia` in the terminal. Copy and paste the code below to install and launch EasyPlotting from within the Julia REPL prompt in the terminal:

```
using Pkg; if haskey(Pkg.installed(), "EasyPlotting") == false; Pkg.add(["PlotlyJS", "ORCA", "ImageMagick", "EasyPlotting"]); end ## Re-installing dependencies manually due to non-detection of these pkgs installed from Manifest.toml in path
using EasyPlotting; retry(EasyPlotting.easymain::Function, delays=ExponentialBackOff(n=5, first_delay=5, max_delay=10))() ## Retry function in case of an IOError when launching Blink
```

As an example, for Julia-1.2.0 running Arch Linux using wayland as the display server protocol:

```
[srgk26@ArchLinux ~]$ wget https://julialang-s3.julialang.org/bin/linux/x64/1.2/julia-1.2.0-linux-x86_64.tar.gz ## Download Julia-1.2.0 into $HOME folder
[srgk26@ArchLinux ~]$ tar -xvzf julia-1.2.0-linux-x86_64.tar.gz && rm julia-1.2.0-linux-x86_64.tar.gz ## Extract Julia-1.2.0 and remove tarball
[srgk26@ArchLinux ~]$ sudo ln -s $HOME/julia-1.2.0/bin/julia /usr/local/bin/julia ## Create symbolic link of the julia binary into a folder in the system PATH
[srgk26@ArchLinux ~]$ sudo -- sh -c 'echo "export QT_QPA_PLATFORM=wayland" >> /etc/environment && source /etc/environment; pacman -S gtk3 python-pip; pip3 install seaborn' ## Combining the commands that require root privileges together
[srgk26@ArchLinux ~]$ julia ## Enter interactive julia REPL session
julia> using Pkg; if haskey(Pkg.installed(), "EasyPlotting") == false; Pkg.add(["PlotlyJS", "ORCA", "ImageMagick", "EasyPlotting"]); end ## Re-installing dependencies manually due to non-detection of these pkgs installed from Manifest.toml in path
       using EasyPlotting; retry(EasyPlotting.easymain::Function, delays=ExponentialBackOff(n=5, first_delay=5, max_delay=10))() ## Retry function in case of an IOError when launching Blink
```

***If the EasyPlotting package precompile stage fails in the terminal, it is likely a problem with your linux setup or hardware. If you have access to a SSH server, you could try to use X11 port forwarding and run the GUI from the server instead. You could also try launching EasyPlotting from within the Juno environment ([check this out](http://docs.junolab.org/v0.6/index.html)).***

***Kindly take note that pressing the 'Plot' button the first time may give an error. Kindly ignore the error message and try again, it will work from the second time.***

If you have already installed this EasyPlotting.jl package, you may prefer to launch the GUI by copying and pasting this instead at the Julia prompt:

```
using EasyPlotting; retry(EasyPlotting.easymain::Function, delays=ExponentialBackOff(n=5, first_delay=5, max_delay=10))() 
```

***Updating EasyPlotting.jl***

There will be regular updates to this EasyPlotting.jl package. If you already have EasyPlotting installed in your system, simply copy and paste:

```
using Pkg; Pkg.update("EasyPlotting"); Pkg.build("EasyPlotting")
```

This fetches the latest updates into your local system. Then simply use the package as per normal.

***

## For advanced users - Docker:

A docker image (repo name: srgk26/easyplotting) for every EasyPlotting.jl release is also provided [here](https://hub.docker.com/r/srgk26/easyplotting/tags).

***

## Credits:

Credits to the developers of the Julia language and libraries. Special thanks to [Dustin T Irwin](https://github.com/dustyirwin) for his script on [Stackoverflow](https://stackoverflow.com/questions/52845964/how-to-use-handlew-flag-with-julia-webio-blink), which helped greatly for the main structure of my code.

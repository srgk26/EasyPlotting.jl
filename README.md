# easy_plotting.app
Statistical plotting GUI app. ***Minimal/no coding required to use.*** 

This is an attempt to create a working GUI app that creates selected scientific plots for user's datasets and user-defined custom options. Simply need to click to select the file that needs to plot, select options such as size and colour, and a plot will be created. The process can be repeated until a satisfactory plot is created, and the PNG image can be saved as desired.

Files of .xlsx/.csv/.txt(tab-delimited) extensions are supported. Example sample.csv and sample.xlsx files are provided in the examples folder. An example of the sample_heatmap.png and a sample screenshot of the GUI is also provided in the examples folder. The GUI screenshot is also shown below:

![Alt text](/examples/App_Screenshot.png?raw=true "Heatmap Plotting")

At the moment, only heatmap plotting is available. Additional plot types will be added in the future.

This GUI is coded in pure Julia. Source scripts are uploaded in the src folder. Currently, only the functional Julia code to be executed from within the Julia REPL is provided. In the near future, fully-functional, standalone applications and executables will be supported for Mac/Windows/Linux distributions.

If anyone would like to contribute, please feel free to submit a pull request. If any issues, please also feel free to open an issue. If particular plotting types are requested to be added into the app, please open an issue as well.

***

**Instructions:**

The following is a step-by-step guide to execute the source scripts to get the GUI running from within the Julia REPL.

  1. Download and run Julia v1.1.0 from: https://julialang.org/downloads/ <*if not already downloaded*>
  2. <*For Windows only*> Download and run 'Chocolatey package manager' from: https://chocolatey.org <*if not already downloaded*>
  3. Open Julia REPL by opening the Julia app
  4. Copy and paste on the Julia prompt to copy this Github repository <*if not already copied*>:
  ```
  cd(homedir()); run(`git clone https://github.com/srgk26/easy_plotting.app.git`); run(`chmod -R u+rwx easy_plotting.app/src/Heatmap_scripts/`)
  ```
  5. Run easy_plotting GUI by copying and pasting on the Julia prompt (This may take some time to start, and may also throw an IOError. Pls re-run the command, it will work):
  ```
  include(joinpath(homedir(), "easy_plotting.app/src/Heatmap_scripts/main_code.jl"))
  ```
 
That's it! Feel free to use and enjoy the app whenever needed.

***

**Credits:**

Credits to the developers of the Julia language and libraries. Special thanks to `@Dustin T Irwin`@https://github.com/dustyirwin for his script on Stackoverflow: https://stackoverflow.com/questions/52845964/how-to-use-handlew-flag-with-julia-webio-blink , which helped greatly for the main structure of my main_code.jl. Also to `@NHDaly`@https://github.com/NHDaly/ApplicationBuilder.jl for his cool ApplicationBuilder.jl package, very useful for bundling applications, executables and their dependencies.

***

*** Deprecated instructions***

*Steps 1: If you don't have any of Python3, Julia or seaborn(Python3) installed, please follow these steps (At the moment, much of these steps only apply to Mac OS X systems as the installation procedures vary for Windows/Linux OS. After Python3/Julia/seaborn installations by other means, the Julia main_code would still be compatible with your system though, regardless of OS - follow steps 2):*

  1. Press Cmd+spacebar to open spotlight --> type 'Terminal' --> open Terminal
  2. Type `git clone https://github.com/srgk26/easy_plotting.app.git` --> press 'enter'
  3. Type `cd easy_plotting.app/src/Heatmap_scripts/`  ## This changes to the folder directory where heatmap scripts are stored. (type 'ls' to list all files within this directory)
  4. Type `chmod u+rwx ./*`  ## This upgrades file permissions for all files in this directory to 'read+write+execute'.
  5. Type `./Initiate_without_PyJulia_MacOS`  ## This step may take about 30 min. Admin password may be requested at the beginning.
  6. Type `julia`  ## Runs Julia within terminal.
  7. Type `include("main_code.jl")`  ## Adds and executes the 'main_code.jl' script. Might be slow or throw an 'IOError' the first time. Pls repeat the command again if this happens, it will work the second time.
  
Now the GUI should run smoothly. Multiple plots can now be plotted at the same time. Just change options as you prefer and click the 'Plot' button when done.

*Steps 2: If you have all of Python3, Julia and seaborn(Python3) installed, please follow these steps:*

  1. Type `julia` in the terminal prompt.  ## Runs Julia within terminal.
  2. Type `include("main_code.jl")`  ## Installs software dependencies if need to. Adds and executes the 'main_code.jl' script. Might be slow or throw an 'IOError' the first time. Pls repeat the command again if this happens, it will work the second time.

***

***Future work:***
  1. Build fully functional, standalone apps for Mac, Windows and Linux distributions.
  2. Add other plotting functionalities and types.

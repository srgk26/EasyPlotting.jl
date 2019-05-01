# easy_plotting.app
Statistical plotting GUI app. ***Minimal/no coding required to use.*** 

This is an attempt to create a working GUI app that creates selected scientific plots for user's datasets and user-defined custom options.

At the moment, only heatmap plotting is available. Additional plot types will be added in the future.

This GUI is coded in pure Julia. Only source scripts are uploaded at this point in time. In the near future, the Julia executable will be bundled with all its dependencies to create a Mac OS X app, possibly also adding options for Windows/Linux distributions.

If anyone would be willing to contribute, please feel free to submit a pull request. If any issues, please also feel free to open an issue.

**Instructions**

A fully self-contained Mac OS easy_plotting.app for heatmap will be released soon in a future update. In the meantime, the main source code is uploaded into the src/Heatmap_scripts folder. The following is a step-by-setp guide to execute these source scripts to get the GUI running.

*Steps 1: If you don't have any of Python3, Julia or seaborn(Python3) installed, please follow these steps (At the moment, much of these steps only apply to Mac OS X systems as the installation procedures vary for Windows/Linux OS. After Python3/Julia/seaborn installations by other means, the Julia main_code would still be compatible with your system though, regardless of OS - follow steps 2):*

  1. Press Cmd+spacebar to open spotlight --> type 'Terminal' --> open Terminal
  2. Type `git clone https://github.com/srgk26/easy_plotting.app.git` --> press 'enter'
  3. Type `cd easy_plotting.app/src/Heatmap_scripts/`  ## This changes to the folder directory where heatmap scripts are stored. (type 'ls' to list all files within this directory)
  4. Type `chmod u+rwx ./*`  ## This upgrades file permissions for all files in this directory to 'read+write+execute'
  5. Type `./Initiate_without_PyJulia`  ## This step may take about 30 min. Admin password will be requested at the beginning.
  6. Type `julia`  ## Runs Julia within terminal
  7. Type `include("main_code.jl")`  ## Adds and executes the 'main_code.jl' script.
  
Now the GUI should run smoothly. At the moment, the GUI can only be used to plot once. To plot again, kindly go back to Julia and type `include("main_code.jl")` again (or simply press the up arrow shortcut to type the last command). In future updates, multiple plots may be able to plotted at once.

*Steps 2: If you have all of Python3, Julia and seaborn(Python3) installed, please follow these steps:*

  1. Type `julia`  ## Runs Julia within terminal
  2. Type `include("Julia_Lib_install.jl")`  ## Installed required libraries and their dependencies. Also adds plotting environment for Python-based plotting packages.
  3. Type `include("main_code.jl")`  ## Adds and executes the 'main_code.jl' script.
  
***Future work:***
  1. Build fully functional, standalone Mac OS app
  2. Add other plotting functionalities and types
  3. Update script to allow for re-plotting without having to re-execute from command line.

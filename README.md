# easy_plotting.app
Statistical plotting GUI app. ***Minimal/no coding required to use.*** 

This is an attempt to create a working GUI app that creates selected scientific plots for user's datasets and user-defined custom options. Simply need to click to select the file that needs to plot, select options such as size and colour, and a plot will be created. The process can be repeated until a satisfactory plot is created, and the PNG image can be saved as desired.

Files of .xlsx/.csv/.txt(tab-delimited) extensions are supported. Example sample.xlsx, sample.csv and sample.txt files are provided in the examples folder. An example of the sample_heatmap.png and a sample screenshot of the GUI app is also provided in the examples folder. The app screenshot is also shown below:

![Alt text](/examples/App_Screenshot.png?raw=true "Heatmap Plotting")

At the moment, only heatmap plotting is available. Additional plot types will be added in the future.

This GUI is coded in pure Julia. Source scripts are uploaded in the src folder. Currently, the functional Julia code is wrapped as a module that can be used as per the instructions below. In the near future, fully-functional, standalone applications and executables will be supported for Mac/Windows/Linux distributions.

If anyone would like to contribute, please feel free to submit a pull request. If any issues, please also feel free to open an issue. If particular plotting types are requested to be added into the app, please open an issue as well.

***

## Instructions:

The following is a step-by-step guide to execute the source scripts to get the GUI running from within the Julia REPL.

### If this is the first time using Julia and this package, pls also follow the following steps:
  1. **<*if not already downloaded*>** Download and run Julia v1.1.0 from: https://julialang.org/downloads/
  2. **<*For Windows only*>** **<*if not already downloaded*>** Download and run 'Chocolatey package manager' from: https://chocolatey.org
  3. Open Julia REPL by opening the Julia app
  4. **<*if not already installed*>** Copy and paste on the Julia prompt to install the easyplotting package and all its dependencies. This process may take upto 20 min for all the dependencies to install.:
  
  **Type ']' before pasting the code below to access the package mode --> prompt will change to the blue (v1.1) pkg>**
  ```
  add https://github.com/srgk26/easy_plotting.app.git
  ```
  
  <br/>
  
### If the easyplotting package has already been previously installed:
  
  5. ***<if there are new updates>*** Copy and paste on the Julia prompt to update this package to include newly updated functionalities:
  
  **Type ']' before pasting the code below to access the package mode --> prompt will change to the blue (v1.1) pkg>**
  ```
  update easyplotting; gc
  ```
  6. Run easy_plotting GUI by copying and pasting on the Julia prompt:
  
  **If need to, press 'backspace' before pasting the code below to return to default julia mode --> prompt will change to the green julia>**
  ```
  using easyplotting; easyplotting.easyheatmap()
  ```
 
That's it! Feel free to use and enjoy the app whenever needed.

***

##Deprecated instructions:

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

##Credits:

Credits to the developers of the Julia language and libraries. Special thanks to `@Dustin T Irwin`@https://github.com/dustyirwin for his script on Stackoverflow: https://stackoverflow.com/questions/52845964/how-to-use-handlew-flag-with-julia-webio-blink , which helped greatly for the main structure of my main_code.jl. Also to `@NHDaly`@https://github.com/NHDaly/ApplicationBuilder.jl for his cool ApplicationBuilder.jl package, very useful for bundling applications, executables and their dependencies.

***

##Future work:
  1. Build fully functional, standalone apps for Mac, Windows and Linux distributions.
  2. Add other plotting functionalities and types.

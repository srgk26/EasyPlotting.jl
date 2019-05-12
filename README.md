# easy_plotting.app
Statistical plotting GUI app. ***Minimal/no coding required to use.*** 

This is an attempt to create a working GUI app that creates selected scientific plots for user's datasets and user-defined custom options. Simply need to click to select the file that needs to plot, select options such as size and colour, and a plot will be created. The process can be repeated until a satisfactory plot is created, and the PNG image can be saved as desired.

Files of .xlsx/.csv/.txt(tab-delimited) extensions are supported. Example sample.xlsx, sample.csv and sample.txt files are provided in the examples folder. An example of the sample_heatmap.png and a sample screenshot of the GUI app is also provided in the examples folder. The app screenshot is also shown below:

![Alt text](/examples/App_Screenshot.png?raw=true "Heatmap Plotting")

At the moment, only heatmap plotting is available. Additional plot types will be added in the future.

This GUI is coded in pure Julia. Source scripts are uploaded in the src folder. Currently, the functional Julia code is wrapped as a module that can be used as per the instructions below. In the near future, fully-functional, standalone applications and executables will be supported for Mac/Windows/Linux distributions.

If anyone would like to contribute, please feel free to submit a pull request. If any issues, please also feel free to open an issue. If particular plotting types are requested to be added into the app, please open an issue as well.

***

## Format of data

This is just a quick heads up on the format your input dataset should be, to produce the desired heatmap figure:

  1. Your dataset must be labelled, where the leftmost column values would correspond to y-axis labels on the heatmap figure while the topmost row values would correspond to x-axis labels on the heatmap figure.
  2. Kindly also take note that the top, leftmost cell in your .xlsx/.csv/.txt file should be non-empty (i.e. row1, column1 cell that intersects row and column labels should be non-empty). It does not matter what the value of that cell is as it would not be reflected in the figure, but the x-axis labels would be compromised if this cell is empty. The screenshot below illustrates what it refers to:
![Alt text](/examples/Nonempty_cell.png?raw=true "Non-empty top leftmost cell")
  3. Please take note that NA values in the dataset is strictly not allowed. I apologise for this, I will try to get this to work in future updates. In the meantime, the GUI does not recognise empty, 'NA' or any non-numerical values in the dataset. Please remove any of these values or substitute them with a neutral number.
  
***

## Instructions:

The following is a step-by-step guide to install this package and get the GUI running from within the Julia REPL.

### Procedure 1: If you have already executed procedure 2 and got the GUI running, simply follow these steps for reuse:
  Open Julia REPL by opening the Julia app and copy and paste on the Julia prompt:
  ```
  using easyplotting; easyplotting.easyheatmap()
  ```
  
  *Note: There will be regular updates to this package to include more functionalities. When an update is released, please also copy and paste this code on the Julia prompt and restart the Julia app to incorporate the changes:*
  
  **Type ']' before pasting the code below to access the package mode --> prompt will change to the blue (v1.1) pkg>**
  ```
  update easyplotting; gc
  ```
 <br/>
 
 ### Procedure 2: If this is your first time using Julia and this package, pls follow the following steps:
  1. Download and run Julia v1.1.0 from: https://julialang.org/downloads/
  <br/> *Note: For non-admin Windows users, simply run it instead of saving it.*
  
  2. Open Julia REPL by opening the Julia app.
  3. Copy and paste on the Julia prompt to install the easyplotting package and all its dependencies. This process takes about 5 minutes for all the dependencies to install:
 
  **Type ']' before pasting the code below to access the package mode --> prompt will change to the blue (v1.1) pkg>**
  ```
  add https://github.com/srgk26/easy_plotting.app.git
  ```
  4. Copy and paste on the Julia prompt to import this easyplotting package to the Julia environment. This process takes about 5 minutes to precompile the easyplotting code and install additional software dependencies:
  
  **Press 'backspace' before pasting the code below to return to default julia mode --> prompt will change to the green julia>**
  ```
  using easyplotting
  ```
  5. Finally, copy and paste on the Julia prompt to run the heatmap GUI app:
  
  *Note1: For Windows non-admin users, there may be a pop-up window prompting for admin login for full access. Kindly ignore the prompt, the app will run without admin login.*
  
  *Note2: During your first use, this may take some time to start, and may also throw an IOError. If it gives an IOError, pls re-run the command, it will work the second time.*
  ```
  easyplotting.easyheatmap()
  ```
 
That's it! Feel free to use and enjoy the app whenever needed.

### Optional:

There is also another function that allows you to install Brew/Choco package managers, Python3, Python3's Seaborn package, and Julia into the root environment. These additional installations are not required to run this easyplotting GUI app, but it may be of use for your other work. Simply copy and paste on the Julia prompt to install these software packages according to your OS. This process may take up to 10 minutes to install (requires admin rights):
```
easyplotting.extrainstall()
```

***

## Credits:

Credits to the developers of the Julia language and libraries. Special thanks to `@Dustin T Irwin`@https://github.com/dustyirwin for his script on Stackoverflow: https://stackoverflow.com/questions/52845964/how-to-use-handlew-flag-with-julia-webio-blink , which helped greatly for the main structure of my main_code.jl. Also to `@NHDaly`@https://github.com/NHDaly/ApplicationBuilder.jl for his cool ApplicationBuilder.jl package, very useful for bundling applications, executables and their dependencies.

***

## Future work:
  1. Accept 'NA'/'NaN' values in dataset.
  2. Build fully functional, standalone apps for Mac, Windows and Linux distributions.
  3. Add other plotting functionalities and types.

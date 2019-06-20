This is just a quick heads up on the format your input dataset should be, to produce the desired Heatmap figure:

  1. Your dataset must have minimum 2 columns labelled with column names. Column 1 is used to label the ticks on the y-axis, while all data from column 2 onwards will be used to plot the heatmap, with their column names being the tick labels for the x-axis.
  2. Kindly also take note that the top, leftmost cell in your .xlsx/.csv/.txt file should be non-empty (i.e. row1, column1 cell that intersects row and column labels should be non-empty). It does not matter what the value of that cell is as it would not be reflected in the figure, but the code would be compromised if this cell is empty. The screenshot below illustrates what it refers to:

![Alt text](/Figures/10sample.PNG?raw=true "Non-empty top leftmost cell")
  
  3. Please take note that NA values in the dataset is strictly not allowed as the code does not recognise empty, "NA" or non-numerical values. Please remove any of these values or substitute them with a neutral number.

This is just a quick heads up on the format your input dataset should be, to produce the desired Scatterplot 3D figure:

  1. Your dataset must have 4 columns labelled with column names. Column 1 is just a dummy column that does not contribute to the plot in any way. But there still has to be a complete column 1 with a column name because of the standardisation required for the code. Column 2 values are used to plot the x-values, column 3 values for the y-axis, while column 4 for the z-axis. Their column names are labelled respectively. You may have more than 4 columns in your dataset, but only the first 4 columns will be used for the Scatterplot 3D figure.
  
  2. Kindly also take note that the top, leftmost cell in your .xlsx/.csv/.txt file should be non-empty (i.e. row1, column1 cell that intersects row and column labels should be non-empty). It does not matter what the value of that cell is as it would not be reflected in the figure, but the code would be compromised if this cell is empty. The screenshot below illustrates what it refers to:

![Alt text](/Figures/3sample.PNG?raw=true "Non-empty top leftmost cell")
  
  3. Please take note that NA values in the dataset is strictly not allowed as the code does not recognise empty, "NA" or non-numerical values. Please remove any of these values or substitute them with a neutral number.

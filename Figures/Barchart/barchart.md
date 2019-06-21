This is just a quick heads up on the format your input dataset should be, to produce the desired Bar Chart figure:

  1. Your dataset must have 2 columns labelled with column names. Column 1 values are used to label the ticks on the x-axis, while the column name for column 2 is used to label the x-axis. You may have more than 2 columns in your dataset, but only the first 2 columns will be used for the Bar Chart.
  2. Kindly also take note that the top, leftmost cell in your .xlsx/.csv/.txt file should be non-empty (i.e. row1, column1 cell that intersects row and column labels should be non-empty). It does not matter what the value of that cell is as it would not be reflected in the figure, but the code would be compromised if this cell is empty. The screenshot below illustrates what it refers to:

![Alt text](/Figures/1sample.PNG?raw=true "Non-empty top leftmost cell")
  
  3. Please take note that NA values in the dataset is strictly not allowed as the code does not recognise empty, "NA" or non-numerical values. Please remove any of these values or substitute them with a neutral number.

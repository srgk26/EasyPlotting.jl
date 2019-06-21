using DataFrames, CSV
df1 = DataFrame(Gene = ["MAGED2", "EIF5A", "AP1S2", "GALK2", "GIT2", "EVI5L", "DUS4L", "TMEM106C", "TPM1", "TPM1", "SVIL", "C20orf112", "TTC7B", "NEDD4L", "CALD1", "HSPD1", "ACTN1", "RASAL2", "VCL", "ERC1"],
                Sample = rand(100:1000, 20))
CSV.write("1sample.csv", df1)

df2 = DataFrame(Gene = ["MAGED2", "EIF5A", "AP1S2", "GALK2", "GIT2", "EVI5L", "DUS4L", "TMEM106C", "TPM1", "TPM1", "SVIL", "C20orf112", "TTC7B", "NEDD4L", "CALD1", "HSPD1", "ACTN1", "RASAL2", "VCL", "ERC1"],
                Sample1 = rand(100:1000, 20), Sample2 = rand(100:1000, 20))
CSV.write("2sample.csv", df2)

dfviolin = DataFrame(Gene = ["Gene$i" for i in 1:10000], Sample1 = rand(100:1000, 10000), Sample2 = rand(100:1000, 10000))
CSV.write("violinsample.csv", dfviolin)

df3 = DataFrame(Gene = ["MAGED2", "EIF5A", "AP1S2", "GALK2", "GIT2", "EVI5L", "DUS4L", "TMEM106C", "TPM1", "TPM1", "SVIL", "C20orf112", "TTC7B", "NEDD4L", "CALD1", "HSPD1", "ACTN1", "RASAL2", "VCL", "ERC1"],
                Sample1 = rand(100:1000, 20), Sample2 = rand(100:1000, 20), Sample3 = rand(100:1000, 20))
CSV.write("3sample.csv", df3)

df10 = DataFrame(Gene = ["MAGED2", "EIF5A", "AP1S2", "GALK2", "GIT2", "EVI5L", "DUS4L", "TMEM106C", "TPM1", "TPM1", "SVIL", "C20orf112", "TTC7B", "NEDD4L", "CALD1", "HSPD1", "ACTN1", "RASAL2", "VCL", "ERC1"],
                Sample1 = rand(100:1000, 20), Sample2 = rand(100:1000, 20), Sample3 = rand(100:1000, 20),
                Sample4 = rand(100:1000, 20), Sample5 = rand(100:1000, 20), Sample6 = rand(100:1000, 20),
                Sample7 = rand(100:1000, 20), Sample8 = rand(100:1000, 20), Sample9 = rand(100:1000, 20),
                Sample10 = rand(100:1000, 20))
CSV.write("10sample.csv", df10)

using StatsPlots, Seaborn
## Bar Chart
StatsPlots.bar(collect(df1[:,2]), xlabel = string(names(df1)[2]), xticks = (1:length(df1[:,1]), df1[:,1]), size = (900,800), color=:lightrainbow, legend=false)
StatsPlots.savefig("barchart_sampleimage.png")

## BoxandWhisker
StatsPlots.boxplot(convert(Matrix, df10[:,2:end]), xticks = (1:size(df10[:,2:end],2), [string(names(df10)[i]) for i in 2:size(df10,2)]), size = (800,600), color=:lightrainbow, legend=false)
StatsPlots.savefig("boxandwhisker_sampleimage.png")

## Histogram
StatsPlots.histogram(collect(df1[:,2]), xlabel = string(names(df1)[2]), size = (600,500), color=:lightrainbow, legend=false)
StatsPlots.savefig("histogram_sampleimage.png")

## Line Graph
StatsPlots.plot(convert(Matrix, df10[:,2:end]), marker = true, markersize = 4, label = [string(names(df10)[i]) for i in 2:size(df10,2)], size = (1000,800), color=:lightrainbow, legend=true)
StatsPlots.savefig("linegraph_sampleimage.png")

## Pie Chart
StatsPlots.pie(collect(df1[:,1]), collect(df1[:,2]), xlabel = string(names(df1)[2]), size = (600,400), color=:lightrainbow)
StatsPlots.savefig("piechart_sampleimage.png")

## Scatterplot 2D
StatsPlots.scatter(collect(df2[:,2]), collect(df2[:,3]), xlabel = string(names(df2)[2]), ylabel = string(names(df2)[3]), size = (600,400), color=:lightrainbow, legend=false)
StatsPlots.savefig("scatterplot2d_sampleimage.png")

## Scatterplot 3D
StatsPlots.scatter3d(collect(df3[:,2]), collect(df3[:,3]), collect(df3[:,4]), xlabel = string(names(df3)[2]), ylabel = string(names(df3)[3]), zlabel = string(names(df3)[4]), size = (800,700), color=:lightrainbow, legend=false)
StatsPlots.savefig("scatterplot3d_sampleimage.png")

## Stripplot
rename!(df10, :S1=>:Gene, :S2=>:S1, :S3=>:S2, :S4=>:S3, :S5=>:S4, :S6=>:S5, :S7=>:S6, :S8=>:S7, :S9=>:S8, :S10=>:S9, :S11=>:S10)
Seaborn.stripplot(data=convert(Matrix, df10[:,2:end]), size=4, jitter=false) ## Seaborn stripplot plotting
Seaborn.xticks(0:size(df10[:,2:end-1],2), [string(names(df10)[i]) for i in 2:size(df10,2)])
Seaborn.savefig("stripplot_sampleimage.png")

## Violinplot
Seaborn.violinplot(x=collect(dfviolin[:,2]), y=collect(dfviolin[:,3]), palette="Purples") ## Seaborn violinplot plotting
Seaborn.xlabel(string(names(dfviolin)[2]))
Seaborn.ylabel(string(names(dfviolin)[3]))
Seaborn.savefig("violinplot_sampleimage.png")

import Blink, Interact, DelimitedFiles, CSV, XLSX, DataFrames, Seaborn, Conda ## Importing required libraries
function easyheatmap() ## Defining function to be called by user
    ## Software packages installation and setup for Mac/Linux/Windows
    @static if Sys.isapple()
        #### Check Mac OS system if required software dependencies are installed.
        ## Install OS packages if not already installed.

        ## Install homebrew if not already installed
        if success(`which brew`) == false
            run(`chmod u+x ./brew_install_MacOS.sh`)
            run(`./brew_install_MacOS.sh`)
        end

        ## Install python3.7 if not already installed
        if success(`which python3`) == false
            run(`brew install python3`)
        elseif success(`which python3`) == true && success(`which python3.7`) == false
            run(`brew reinstall python3`)
        end

        ## Install seaborn python3 package if not already installed
        if in("seaborn", readdir(joinpath(chomp(read(`which python3`, String))[1:end-11], "lib/python3.7/site-packages/"))) == false
            run(`pip3 install --upgrade pip`)
            run(`pip3 install seaborn`)
        end

        ## Install julia if not already installed
        if success(`which julia`) == false
            run(`brew cask install julia`)
        end
    end

    @static if Sys.islinux()
        #### Check Linux OS system if required software dependencies are installed.
        ## Install OS packages if not already installed.

        ## Install linuxbrew if not already installed
        if success(`which brew`) == false
            run(`chmod u+x ./brew_install_Linux.sh`)
            run(`./brew_install_Linux.sh`)
        end

        ## Install python3.7 if not already installed
        if success(`which python3`) == false
            run(`brew install python3`)
        elseif success(`which python3`) == true && success(`which python3.7`) == false
            run(`brew reinstall python3`)
        end

        ## Install seaborn python3 package if not already installed
        if in("seaborn", readdir(joinpath(chomp(read(`which python3`, String))[1:end-11], "lib/python3.7/site-packages/"))) == false
            run(`pip3 install --upgrade pip`)
            run(`pip3 install seaborn`)
        end

        ## Install julia if not already installed
        if success(`which julia`) == false
            if success(`which apt`) == true
                run(`sudo apt-get update`)
                run(`sudo apt-get dist-upgrade`)
                run(`sudo apt-get install julia`)
            elseif success(`which dnf`) == true
                run(`sudo dnf update`)
                run(`sudo yum update`)
                run(`sudo dnf copr enable nalimilan/julia`)
                run(`sudo yum install julia`)
            elseif success(`which dnf`) == false && success(`which yum`) == true
                run(`sudo yum update`)
                run(`sudo yum-config-manager --add-repo https://copr.fedorainfracloud.org/coprs/nalimilan/julia/repo/epel-7/nalimilan-julia-epel-7.repo`)
                run(`sudo yum install julia`)
            elseif success(`which pkg`) == true
                run(`pkg upgrade`)
                run(`pkg install julia`)
            elseif success(`which pacman`) == true
                run(`pacman -Syu`)
                run(`pacman -S julia`)
            end
        end
    end
    
    @static if Sys.iswindows()
        #### Check Windows OS system if required software dependencies are installed.
        ## Install OS packages if not already installed.
        
        If chomp(read(`powershell.exe Get-ExecutionPolicy`, String)) == "restricted"
	        run(`powershell.exe Set-ExecutionPolicy -Scope CurrentUser Bypass`)
			run(`powershell.exe refreshenv`)
        end

        function input(prompt::String="")
            print(prompt)
            return chomp(readline())
        end
        admin = input("Are you an admin? [Y]es or [N]o: ")
	
		if admin == "Y" || "y"
			if success(`powershell.exe where.exe choco`) == false
				run(`powershell.exe choco_install_admin.ps1`)
				run(`powershell.exe refreshenv`)
			end
		
			if success(`powershell.exe where.exe python`) == false
				run(`powershell.exe choco install python3 --confirm`)
			elseif success(`powershell.exe where.exe python3`) == true && chomp(read(`powershell.exe where.exe python`, String))[end-12] !== "3"
				run(`powershell.exe choco install python3 --confirm`)
			elseif success(`powershell.exe where.exe python3`) == true && chomp(read(`powershell.exe where.exe python`, String))[end-12] == "3" && chomp(read(`powershell.exe where.exe python`, String))[end-11] !== "7"
				run(`powershell.exe choco upgrade python3 --confirm`)
			end
		
			if in("seaborn", joinpath(readdir(`powershell.exe where.exe python`)[1:end-10], "lib/site-packages")) == false
            	run(`pip3 install --upgrade pip`)
            	run(`pip3 install seaborn`)
        	end
		
			if success(`powershell.exe where.exe julia`) == false
            	run(`powershell.exe choco install julia --confirm`)
        	end
		elseif admin == "N" || "n"
			if success(`powershell.exe where.exe choco`) == false
				run(`powershell.exe choco_install_nonadmin.ps1`)
				run(`powershell.exe refreshenv`)
			end
		
			if success(`powershell.exe where.exe python`) == false
				run(`powershell.exe python3_install_nonadmin.ps1`)
			elseif success(`powershell.exe where.exe python3`) == true && chomp(read(`powershell.exe where.exe python`, String))[end-12] !== "3"
				run(`powershell.exe python3_install_nonadmin.ps1`)
			elseif success(`powershell.exe where.exe python3`) == true && chomp(read(`powershell.exe where.exe python`, String))[end-12] == "3" && chomp(read(`powershell.exe where.exe python`, String))[end-11] !== "7"
				run(`powershell.exe python3_install_nonadmin.ps1`)
			end
		
			if in("seaborn", joinpath(readdir(`powershell.exe where.exe python`)[1:end-10], "lib/site-packages")) == false
            	run(`pip3 install --upgrade pip`)
            	run(`pip3 install seaborn`)
        	end
		
			if success(`powershell.exe where.exe julia`) == false
            	run(`powershell.exe julia_install_nonadmin.ps1 `)
        	end
		end
	
		run(`powershell.exe refreshenv`)
    end

    #### Install additional required Julia installations if not already installed
    ## Installing Electron browser (and renaming to Julia.app)
    if in("Julia.app", readdir(joinpath(pathof(Blink)[1:end-12], "deps"))) == false
        Blink.AtomShell.install()
    end
    
    ## Adding pyqt matplotlib backend for compatibility with seaborn plots
    @static if Sys.isapple() || Sys.islinux()
        if in("backend_qt5.py", readdir(joinpath(chomp(read(`which python3`, String))[1:end-11], "lib/python3.7/site-packages/matplotlib/backends"))) == false
            Conda.add("pyqt")
        end
    end

    @static if Sys.iswindows()
        if in("backend_qt5.py", readdir(joinpath(chomp(read(`powershell.exe where.exe python`, String))[1:end-10], "lib/site-packages/matplotlib/backends"))) == false
            Conda.add("pyqt")
        end
    end

    #### Main code for heatmap plotting GUI
    w = Blink.Window() ## Opening Blink window

    ## Defining input widgets for data selection
    function page_inputs()
        file = Interact.filepicker(accept=[".csv", ".txt", ".xlsx"]) ## Restricting file input types
        sheet = Interact.textbox("sheet name")
        clustering = Interact.dropdown(["row", "column", "both", "none"])
        size1 = Interact.textbox("Default: x-axis = 6")
        size2 = Interact.textbox("Default: y-axis = 7")
        colours = Interact.dropdown(["Default", "Blues", "Reds", "Purples", "Greens", "mako", "BuGn_r", "cubehelix", "BrBG", "RdBu_r", "coolwarm"])
        enter_button = html"""<button onclick='Blink.msg("press", "foo")'>Plot</button>"""  ## Using HTML format since action-on-click works with this
        Interact.Widget(["file"=>file, "sheet"=>sheet, "clustering"=>clustering, "size1"=>size1, "size2"=>size2, "colours"=>colours, "enter_button"=>enter_button])
    end
    inputs = page_inputs()

    ## Designing page layout
    page = Interact.node(:div,
                Interact.node(:p, "Upload data file below - only .txt/.csv/.xlsx file extensions accepted:", style=Dict(:color=>"blue", :size=>"80", :padding=>"5px")),
                Interact.node(:div, inputs["file"]),
                Interact.node(:div),
                Interact.node(:p, hbox(pad(0.5em, "If .xlsx file, pls also enter sheet name (case & space sensitive):"), pad(0.25em, inputs["sheet"])), style=Dict(:color=>"red", :size=>"40", :padding=>"5px")),
                Interact.node(:p, hbox(pad(0.5em, "Choose options for dendrogram clustering:"), pad(0.25em, inputs["clustering"])), style=Dict(:color=>"blue", :size=>"40", :padding=>"5px")),
                Interact.node(:p, hbox(pad(0.5em, "(Optional) Enter plot size (numbers only):"), pad(0.25em, inputs["size1"]), pad(0.25em, inputs["size2"])), style=Dict(:color=>"green", :size=>"40", :padding=>"5px")),
                Interact.node(:p, hbox(pad(0.5em, "(Optional) Select fill colour palette for heatmap:"), pad(0.25em, inputs["colours"])), style=Dict(:color=>"blue", :size=>"40", :padding=>"5px")),
                Interact.node(:p, inputs["enter_button"]))

    Blink.body!(w, page) ## Adding page layout options to Blink window 'w'
    Blink.title(w, "Heatmap") ## Adding title to Blink window 'w'

    ## Defining function -- plotting instructions -- to be called from within Plot(w, inputs) function
    function Fig()
        tmpdir = mktempdir()
        fig = joinpath(tmpdir, "tmp_heatmap.png")
        savefig(fig)
        run(`open $fig`)
    end

    ## Main function code to plot heatmap, using user-defined input options
    function Plot()
        if (inputs["file"][]::String)[end-3:end] == "xlsx" ## If input file is .xlsx
            df = DataFrame(XLSX.readtable((inputs["file"][]::String), (inputs["sheet"][]::String))...) ## Convert dataset to dataframe
            if inputs["clustering"][] == "both" ## For row+column clustering option
                if inputs["size1"][]::String == "" ## If no user-input for plot size
                    if inputs["colours"][] == "Default" ## If no user-input for plot colours
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(6,7)) ## Seaborn Clustermap plotting
                        Fig() ## Call Fig() function defined above
                        return true ## Returns true value, thereby stopping while loop that keeps the process running
                    else ## If plot colours is defined by user
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else ## If plot size is defined by user
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "row" ## For row clustering option
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "column" ## For column clustering option
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            else ## For no clustering option
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            end
        elseif (inputs["file"][]::String)[end-2:end] == "csv" ## If input file is .csv
            df = DataFrame(CSV.read(inputs["file"][]::String))
            if inputs["clustering"][] == "both"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "row"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), col_cluster=false, figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "column"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            else
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[:,2:end]), xticklabels=names(df)[2:end], yticklabels=collect(df[:,1]), row_cluster=false, col_cluster=false, figsize=(parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            end
        elseif (inputs["file"][]::String)[end-2:end] == "txt" ## If input file is .txt
            df = DataFrame(readdlm(inputs["file"][]::String, '\t'))
            if inputs["clustering"][] == "both"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), (parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), (parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "row"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), col_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), col_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), col_cluster=false, (parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), col_cluster=false, (parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            elseif inputs["clustering"][] == "column"
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, (parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, (parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            else
                if inputs["size1"][]::String == ""
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, col_cluster=false, figsize=(6,7))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, col_cluster=false, figsize=(6,7), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                else
                    if inputs["colours"][] == "Default"
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, col_cluster=false, (parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])))
                        Fig()
                        return true
                    else
                        clustermap(convert(Matrix, df[2:end,2:end]), xticklabels=collect(df[1,2:end]), yticklabels=collect(df[2:end,1]), row_cluster=false, col_cluster=false, (parse(Float, inputs["size1"][]), parse(Float, inputs["size2"][])), cmap=(inputs["colours"][]::String))
                        Fig()
                        return true
                    end
                end
            end
        end
    end

    #### Defining function that keeps the function Plot(w, input) running until true boolean value is returned
    function events()
        @async while true ## Syncing all processes above
            Plot() == true ? (sleep(5) && break) : sleep(0.001) ## If true is returned, process sleeps and breaks. Until then, it keeps running.
        end
    end

    #### This is a method of message passing inference between javascript used in Blink and Julia
    Blink.handle(w, "press") do args...  ## When enter_button is pressed, the following arguments are executed
      events()  ## When enter_button is pressed, events(w, inputs) is executed.
    end
end

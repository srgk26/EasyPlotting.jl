#### Software packages installations and setup for Mac/Linux/Windows(admin & non-admin) OS
function extrainstall()
    ### Check Mac OS system if required software dependencies are installed.
    ## Install OS packages if not already installed.
    @static if Sys.isapple()
        ## Install homebrew if not already installed
        if success(`which brew`) == false
            run(`chmod u+x ./extrainstall/brew_install_MacOS.sh`)
            run(`./extrainstall/brew_install_MacOS.sh`)
        end

        ## Install python3.7 if not already installed
        if success(`which python3`) == false
            run(`brew install python3`)
        elseif success(`which python3`) == true && success(`which python3.7`) == false
            run(`brew reinstall python3`)
        end

        ## Install seaborn python3 package if not already installed
        try ## Trying try/catch blocks in the event something goes wrong in the user's computer, the process would be executed anyway
            if in("seaborn", readdir(joinpath(chomp(read(`which python3`, String))[1:end-11], "lib/python3.7/site-packages/"))) == false
                run(`pip3 install --upgrade pip`)
                run(`pip3 install seaborn`)
            end
        catch
            run(`pip3 install --upgrade pip`)
            run(`pip3 install seaborn`)
        end

        ## Adding pyqt matplotlib backend for compatibility with seaborn plots
        try
            if in("backend_qt5.py", readdir(joinpath(chomp(read(`which python3`, String))[1:end-11], "lib/python3.7/site-packages/matplotlib/backends"))) == false
                Conda.add("pyqt")
            end
        catch
            Conda.add("pyqt")
        end

        ## Install julia in PATH if not already installed
        if success(`which julia`) == false
            run(`brew cask install julia`)
        end
    end

    ### Check Linux OS system if required software dependencies are installed.
    ## Install OS packages if not already installed.
    @static if Sys.islinux()
        ## Install linuxbrew if not already installed
        if success(`which brew`) == false
            run(`chmod u+x ./extrainstall/brew_install_Linux.sh`)
            run(`./extrainstall/brew_install_Linux.sh`)
        end

        ## Install python3.7 if not already installed
        if success(`which python3`) == false
            run(`brew install python3`)
        elseif success(`which python3`) == true && success(`which python3.7`) == false
            run(`brew reinstall python3`)
        end

        ## Install seaborn python3 package if not already installed
        try
            if in("seaborn", readdir(joinpath(chomp(read(`which python3`, String))[1:end-11], "lib/python3.7/site-packages/"))) == false
                run(`pip3 install --upgrade pip`)
                run(`pip3 install seaborn`)
            end
        catch
            run(`pip3 install --upgrade pip`)
            run(`pip3 install seaborn`)
        end

        ## Adding pyqt matplotlib backend for compatibility with seaborn plots
        try
            if in("backend_qt5.py", readdir(joinpath(chomp(read(`which python3`, String))[1:end-11], "lib/python3.7/site-packages/matplotlib/backends"))) == false
                Conda.add("pyqt")
            end
        catch
            Conda.add("pyqt")
        end

        ## Install julia in PATH if not already installed
        try
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
        catch
            nothing ## If Julia installation in path is unsuccessful, do nothing as Julia would already be installed by user anyway.
        end
    end

    ### Check Windows OS system if required software dependencies are installed.
    ## Install OS packages if not already installed.
    @static if Sys.iswindows()
        ## Bypassing script execution restrictions with Windows powershell 
        if chomp(read(`powershell.exe Get-ExecutionPolicy`, String)) == "restricted"
            run(`powershell.exe Set-ExecutionPolicy -Scope CurrentUser Bypass`)
        end

        ## Asking if user is an admin user
        function Input(prompt::String)
            print(prompt)
            return chomp(readline())
        end
        admin = Input("Are you an admin? [Y]es or [N]o: ")

        ## Software installations for admin users
        if admin == "Y" || admin == "y"
            ## Install chocolatey if not already installed
            if success(`powershell.exe where.exe choco`) == false
                run(`powershell.exe Set-ExecutionPolicy Bypass -Scope Process; ./extrainstall/choco_install_admin.ps1`)
            end

            ## Install python3.7 if not already installed
            if success(`powershell.exe where.exe python`) == false
                run(`powershell.exe choco install python3 --confirm`)
            elseif success(`powershell.exe where.exe python3`) == true && chomp(read(`powershell.exe where.exe python`, String))[end-12] !== "3"
                run(`powershell.exe choco install python3 --confirm`)
            elseif success(`powershell.exe where.exe python3`) == true && chomp(read(`powershell.exe where.exe python`, String))[end-12] == "3" && chomp(read(`powershell.exe where.exe python`, String))[end-11] !== "7"
                run(`powershell.exe choco upgrade python3 --confirm`)
            end

            ## Install seaborn python3 package if not already installed
            try
                try
                    if in("seaborn", readdir(joinpath(chomp(read(`powershell.exe where.exe python`, String))[1:end-10], "lib/site-packages"))) == false
                        run(`pip3 install --upgrade pip`)
                        run(`pip3 install seaborn`)
                    end
                catch
                    run(`pip3 install --upgrade pip`)
                    run(`pip3 install seaborn`)
                end
            catch
                run(`pip install seaborn`)
            end

            ## Adding pyqt matplotlib backend for compatibility with seaborn plots
            try
                if in("backend_qt5.py", readdir(joinpath(chomp(read(`powershell.exe where.exe python`, String))[1:end-10], "lib/site-packages/matplotlib/backends"))) == false
                    Conda.add("pyqt")
                end
            catch
                Conda.add("pyqt")
            end

            ## Install julia in PATH if not already installed
            if success(`powershell.exe where.exe julia`) == false
                run(`powershell.exe choco install julia --confirm`)
            end
            
        ## Software installations for non-admin users
        ## For non-admin users, only critical software applications will be installed as non-critical additional software installations are suboptimal
        elseif admin == "N" || admin == "n"
            ## Install python3.7 if not already installed
            #=try
                if in("python.3.7.3", readdir(joinpath(homedir(), "AppData/Local/PackageManagement/NuGet/Packages"))) == false
                    run(`powershell.exe Set-ExecutionPolicy Bypass -Scope Process; ./python3_install_nonadmin.ps1`)
                end
            catch
                run(`powershell.exe Set-ExecutionPolicy Bypass -Scope Process; ./python3_install_nonadmin.ps1`)
            end

            ## Install seaborn python3 package if not already installed
            try
                if in("seaborn", readdir(joinpath(homedir(), "AppData/Local/Programs/Python/Python37/lib/site-packages"))) == false
                    run(`pip3 install --upgrade pip`)
                    run(`pip3 install seaborn`)
                end
            catch
                run(`pip3 install --upgrade pip`)
                run(`pip3 install seaborn`)
            end=#
            
            ## Adding pyqt matplotlib backend for compatibility with seaborn plots
            try
                if in("backend_qt5.py", readdir(joinpath(homedir(), "AppData/Local/Programs/Python/Python37/lib/site-packages"))) == false
                    Conda.add("pyqt")
                end
            catch
                Conda.add("pyqt")
            end
            
        else
            ## Throw error exception in the event the user presses any other key
            error("Invalid input. Please re-run the command and enter only 'Y' or 'N'.")
        end
    end

    ## Installing Electron browser (and renaming to Julia.app)
    try
        if in("Julia.app", readdir(joinpath(pathof(Blink)[1:end-12], "deps"))) == false
            Blink.AtomShell.install()
        end
    catch
        Blink.AtomShell.install()
    end
end

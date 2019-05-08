cd(pathof(easyplotting)[1:end-15])  ## Remove this as it's already added in easyplotting.jl

If chomp(read(`powershell.exe Get-ExecutionPolicy`, String)) == "restricted"
	run(`powershell.exe Set-ExecutionPolicy Bypass -Scope Process`)
end

function input(prompt::String="")
	print(prompt)
        return chomp(readline())
end
admin = input("Are you an admin? [Y]es or [N]o: ")

if success(`powershell.exe where.exe choco`) == false
	if admin == "Y" || "y"
		run(`powershell.exe choco_install_admin.ps1`)
	elseif admin == "N" || "n"
		run(`powershell.exe choco_install_nonadmin.ps1`)
	end
	run(`powershell.exe refreshenv`)
end

if success(`powershell.exe where.exe python`) == false
	if admin == "Y" || "y"
		run(`powershell.exe choco install python3 --confirm`)
	elseif admin == "N" || "n"
		run(`powershell.exe python3_install_nonadmin.ps1`)
	end
	run(`powershell.exe refreshenv`)
end

if success(`powershell.exe where.exe python3`) == true && chomp(read(`powershell.exe where.exe python`, String))[end-12] == "3" && chomp(read(`powershell.exe where.exe python`, String))[end-11] !== "7"
	if admin == "Y" || "y"
		run(`powershell.exe choco upgrade python3 --confirm`)
	elseif admin == "N" || "n"
		run(`powershell.exe python3_install_nonadmin.ps1`)
	end
	run(`powershell.exe refreshenv`)
end

if in("seaborn", joinpath(readdir(`powershell.exe where.exe python`)[1:end-9], "lib/site-packages")) == false
	run(`pip3 install --upgrade pip`)
	run(`pip3 install seaborn`)
end


if success(`powershell.exe where.exe julia`) == false
	run(`powershell.exe choco install julia --confirm`)
end

#####################################################################################################################



if success(`powershell.exe where.exe choco`) == false
    if chomp(read(`powershell.exe Get-ExecutionPolicy`, String)) == "Restricted"
        if success(`powershell.exe Set-ExecutionPolicy Bypass -Scope Process`) == true
            run(`powershell.exe Set-ExecutionPolicy Bypass -Scope Process`)
        else
            run(`powershell.exe Set-ExecutionPolicy -Scope CurrentUser Bypass`)
        end
    end
    
    cd(pathof(easyplotting)[1:end-15])
    if success(`powershell.exe ./choco_install_Windows_admin.ps1`) == true
        run(`powershell.exe ./choco_install_Windows_admin.ps1`)
    else
        run(`powershell.exe ./choco_install_Windows_non_admin.ps1`)
    end
end

if success(`powershell.exe where.exe /R C: python3`) == false
    if chomp(read(`powershell.exe Get-ExecutionPolicy`, String)) == "Restricted"
        if success(`powershell.exe Set-ExecutionPolicy Bypass -Scope Process`) == true
            run(`powershell.exe Set-ExecutionPolicy Bypass -Scope Process`)
        else
            run(`powershell.exe Set-ExecutionPolicy -Scope CurrentUser Bypass`)
        end
    end
    
    cd(pathof(easyplotting)[1:end-15])
    if success(`powershell.exe choco install python3 --confirm`) == true
        run(`powershell.exe choco install python3 --confirm`)
    else
        run(`powershell.exe ./python3_non_admin_install.ps1`)
    end
end

if success(`powershell.exe where.exe /R C: python3`) == true && success(`powershell.exe where.exe /R C: python37`) == false
    if chomp(read(`powershell.exe Get-ExecutionPolicy`, String)) == "Restricted"
        if success(`powershell.exe Set-ExecutionPolicy Bypass -Scope Process`) == true
            run(`powershell.exe Set-ExecutionPolicy Bypass -Scope Process`)
        else
            run(`powershell.exe Set-ExecutionPolicy -Scope CurrentUser Bypass`)
        end
    end

    cd(pathof(easyplotting)[1:end-15])
    if success(`powershell.exe choco upgrade python3 --confirm`) == true
        run(`powershell.exe choco upgrade python3 --confirm`)
    else
        run(`powershell.exe ./python3_non_admin_upgrade.ps1`)
    end
end

if success(`powershell.exe where.exe /R C: julia`) == false
    run(`powershell.exe choco install julia --confirm`)
end

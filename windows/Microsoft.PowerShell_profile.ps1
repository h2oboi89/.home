# Git Settings
Import-Module posh-git

$GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "HH:mm:ss") '
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'
$GitPromptSettings.EnableFileStatus = $false

# C# Solution project output directory cleaning function
# - Reads *.sln file and iterates through *.csproj Projects and cleans out bin/ and obj/ directories
function Clean-OutputDirectories {
    $solution = (Get-ChildItem -Path . -Filter *.sln).Name
    
    if(!$solution) {
        echo "not in solution folder"
        return    
    }

    # get list of projects from Solution file
    $projects = Get-Content $solution | Select-String "{2150E333-8FDC-42A3-9474-1A3956D46DE8}" -NotMatch | Select-String 'Project\(' | 
                    ForEach-Object {
                        $projectParts = $_ -Split '[,=]' | ForEach-Object { $_.Trim('[ "{}]') };
                        New-Object psobject -Property @{
                            Name = $projectParts[1];
                            File = $projectParts[2];
                        }
                    }

    # filter out Installer Projects
    $projects = $projects | Where-Object {$_.File.EndsWith("csproj")}

    # iterate through projects and delete output directories
    foreach($project in $projects) {
        $path = $PWD.Path + "\" + $project.File.Replace($project.Name + ".csproj", "")

        $directories = "bin", "obj"

        foreach($dir in $directories) {
            $d = $path + $dir
            $d
            Remove-Item $d -Recurse -ErrorAction Ignore
        }
    }
}

# Aliases
New-Alias nano "C:\Program Files\Git\usr\bin\nano.exe"
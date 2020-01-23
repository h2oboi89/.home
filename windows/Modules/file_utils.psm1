# C# Solution Projects
# - gets a list of projects listed in a solution
function Get-SolutionProjects {
    $solution = (Get-ChildItem -Path . -Filter *.sln).Name
    
    if(!$solution) {
        # Write-Error "not in solution folder"
        Throw "not in solution folder"
    }

    # get list of projects from Solution file
    $projects = Get-Content $solution | 
                Select-String 'Project\(' | 
                Select-String "{2150E333-8FDC-42A3-9474-1A3956D46DE8}" -NotMatch | # skip solution folders
                ForEach-Object {
                    $projectParts = $_ -Split '[,=]' | ForEach-Object { $_.Trim('[ "{}]') };
                    
                    New-Object psobject -Property @{
                        Name = $projectParts[1];
                        File = $projectParts[2];
                    }
                }

    # filter out Installer Projects
    $projects = $projects | Where-Object {$_.File.EndsWith("csproj")}
    
    return $projects
}

# C# Solution files
# - gets a list of all solution source files (excluding *AssemblyInfo.cs files)
function Get-SolutionFiles {
    foreach($project in Get-SolutionProjects) {
        $path = $project.File.Replace($project.Name + ".csproj", "")
        
        Get-Content $project.File | Select-String '<Compile' | Select-String 'AssemblyInfo.cs' -NotMatch |
            ForEach-Object {
                $parts = $_ -Split '["]'
                New-Object psobject -Property @{ Path = $path + $parts[1] }
            }
    }
}

# C# Solution file header utility
# - Adds file header to solution source files (deletes existing if it is present)
function Add-FileHeaders {
    $solution = (Get-ChildItem -Path . -Filter *.sln).Basename
    
    foreach($f in Get-SolutionFiles) {
        $f
    
        $content = [System.Collections.ArrayList](Get-Content $f.Path)
        
        # remove existing header
        while ($true) {
            if($content[0].StartsWith("//")) {
                $content.RemoveAt(0)
            }
            else {
                break
            }
        }
        
        # remove leading blank lines
        while ($true) {
            if($content[0].length -eq 0) {
                $content.RemoveAt(0)
            }
            else {
                break
            }
        }
        
        $header = "// " + $solution + "\" + $f.Path + "`r`n// Copyright GE Appliances - Confidential - All rights reserved`r`n"
        
        Set-Content $f.Path -value $header,$content.ToArray()
    }
}

# C# Solution project output directory cleaning function
# - Reads *.sln file and iterates through *.csproj Projects and deletes bin/ and obj/ directories
function Remove-OutputDirectories {
    foreach($project in Get-SolutionProjects) {
        $path = $project.File.Replace($project.Name + ".csproj", "")

        $directories = "bin", "obj"

        foreach($dir in $directories) {
            $d = $path + $dir
            $d
            Remove-Item $d -Recurse -ErrorAction Ignore
        }
    }
}

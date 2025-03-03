# C# Solution Projects
# - gets a list of projects listed in a solution
function Get-SolutionProjects {
    $solution = (Get-ChildItem -Path . -Filter *.sln).Name
    
    if (!$solution) {
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
    $projects = $projects | Where-Object { $_.File.EndsWith("csproj") }
    
    return $projects
}

# creates a dependency graph using yUML syntax (https://yuml.me/)
function Get-DependencyGraph {
    $ns = @{ defaultNamespace = "http://schemas.microsoft.com/developer/msbuild/2003" }

    foreach ($project in Get-SolutionProjects) {
        $projectFile = $project.File
        $projectName = $project.Name

        $projectReferences = [xml](Get-Content $projectFile) | 
        Select-Xml '//defaultNamespace:ProjectReference/defaultNamespace:Name' -Namespace $ns | 
        Select-Object -ExpandProperty Node | 
        Select-Object -ExpandProperty "#text"

        if ($projectReferences.count -eq 0) {
            "[" + $projectName + "] -> [Nothing]"
        }
        else {
            foreach ($reference in $projectReferences) {
                "[" + $projectName + "] -> [" + $reference + "]"
            }
        }
    }

    ""
    "yuml.me"
}

# C# Solution project output directory cleaning function
# - Reads *.sln file and iterates through *.csproj Projects and deletes bin/ and obj/ directories
function Remove-OutputDirectories {
    foreach ($project in Get-SolutionProjects) {
        $path = $project.File.Replace($project.Name + ".csproj", "")

        $directories = "bin", "obj"

        foreach ($dir in $directories) {
            $d = $path + $dir
            $d
            Remove-Item $d -Recurse -ErrorAction Ignore
        }
    }
}
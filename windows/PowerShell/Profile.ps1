# Git Settings
Import-Module posh-git
Import-Module file-utils

$GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "HH:mm:ss") '
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'
$GitPromptSettings.EnableFileStatus = $false

function Open-Gea-Repo { 
  Set-Location "~\workspace\cs\gea3_45" 
}

function Open-Newfi-Repo { 
  Set-Location "~\workspace\cs\newfi_45"
}

function Open-Aui-Repo {
  Set-Location "~\workspace\cs\auiTool" 
}

function Open-VisualStudio {
  Start-Process (Get-ChildItem .\*.sln)[0].Name
}

function Open-GitUrl {
  $RemoteURL = git config remote.origin.url

  if ($RemoteURL) {

    if ($RemoteURL -match '\.git$') { $RemoteURL = $RemoteURL -replace '\.git$', '/' }

    Start-Process $RemoteURL
  }
  else {
    Write-Warning 'Could not retrieve remote.origin.url. Are you in a git folder?'
  }
}

function Open-CoverageReport {
  $CoverageFile = .\OpenCover\index.html

  Start_Process $CoverageFile
}

# Aliases
Set-Alias nano "C:\Users\220040509\AppData\Local\Programs\Git\usr\bin\nano.exe"
        
# remove Powershell alias
Remove-Alias -Name ls -Force
    
Set-Alias ls 'C:\Users\220040509\AppData\Local\Programs\Git\usr\bin\ls.exe'

New-Alias lua lua53
    
New-Alias gho Open-GitUrl
    
New-Alias gea Open-Gea-Repo
    
New-Alias newfi Open-Newfi-Repo
    
New-Alias aui Open-Aui-Repo
    
New-Alias vs Open-VisualStudio

New-Alias cover Open-CoverageReport

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

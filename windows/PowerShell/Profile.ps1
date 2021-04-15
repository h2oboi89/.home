# Git Settings
Import-Module posh-git
Import-Module file-utils

$GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "HH:mm:ss") '
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'
$GitPromptSettings.EnableFileStatus = $false

# Aliases
try {
    New-Alias nano "C:\Program Files\Git\usr\bin\nano.exe" -ErrorAction Stop

    # override windows `tree` with Unix version
    Set-Alias tree "C:\Program Files (x86)\GnuWin32\bin\tree.exe" -Force
    
    # remove Powershell alias and use GnuWin32 versions
    Remove-Alias -Name ls -Force
    Remove-Alias -Name rm -Force
    New-Alias lua lua53
} catch {}
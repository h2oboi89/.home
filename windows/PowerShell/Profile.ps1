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

    # use GNU Win32 installed vs built-in
    del alias:ls -Force
    del alias:rm -Force
} catch {}
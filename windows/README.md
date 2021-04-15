# Things to Install

- [VSCode](https://code.visualstudio.com/download)
- [Visual Studio](https://visualstudio.microsoft.com/downloads/)
- [Git](https://git-scm.com/downloads)
- [GnuWin32](http://gnuwin32.sourceforge.net/packages.html)
    - [CoreUtils](http://gnuwin32.sourceforge.net/packages/coreutils.htm) to start, more as needed
- [PowerShell](https://github.com/PowerShell/PowerShell/releases)
- [Windows Terminal](https://github.com/microsoft/terminal/releases)
    - also available via the Microsoft Store
- [7zip](https://www.7-zip.org/download.html)
- [Lua](https://www.lua.org/download.html)
- [Python 3](https://www.python.org/downloads/windows/)
    - be sure to install the `py` launcher
- [Doxygen](https://www.doxygen.nl/download.html)

# Path Modifications

NOTE: Most programs above should include option to add to path in their installer. Exceptions are listed below.

- C:\Program Files (x86)\GnuWin32\bin
    - lets you use GnuWin32 utils in shell
- C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin
    - lets you call MsBuild from the command line
    - NOTE: the path will change between version of VS (one shown is for 2019 - Community)
- C:\Program Files\7-Zip
- C:\Program Files\Lua53

# Configuration Files
Location: `C:\Users\<USERNAME>`
- .gitconfig
- .bash_profile

Location: `C:\Users\<USERNAME>\Documents\PowerShell`
- PowerShell Folder
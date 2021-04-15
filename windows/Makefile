################################################################################
# Makefile for building and cleaning the GEA3 Dlls.
################################################################################

###############################
# Variables
###############################
# Build tools and related variables
SHELL := C:\Windows\System32\cmd.exe
ZIP_TOOL := .\Tools\build-tools.zip\7zip.exe
COMPILER := .\Tools\build-tools.csharp2017\MSBuild\15.0\Bin\MSBuild.exe
PYTHON3 := py -3
LUA53:= .\Tools\build-tools.lua53\windows\lua53.exe

# TDD tools and related variables
PACKAGE_ROOT := $(shell echo $(USERPROFILE))\.nuget\packages

TDD_TOOL := $(PACKAGE_ROOT)\nunit.consolerunner\3.10.0\tools\nunit3-console.exe
TDD_DIR := .\OpenCover

COVERAGE_TOOL := $(PACKAGE_ROOT)\opencover\4.7.922\tools\OpenCover.Console.exe
COVERAGE_REPORT_TOOL := $(PACKAGE_ROOT)\reportgenerator\4.3.6\tools\net47\ReportGenerator.exe
COVERAGE_REPORT := $(TDD_DIR)\results.xml

TESTS = .\UnitTests\bin\$(CONFIG)\UnitTests.dll

OPENCOVER_ASSEMBLY_FILTER := -nunit.framework;-UnitTests;
@echo off
echo Please wait, toggling adapters ...

netsh interface show interface

rem Toggle LAN
set "local=DISABLE"
netsh interface show interface name="Local Area Connection" | find /i "Disabled" > nul && set "local=ENABLE"
@echo on
netsh interface set interface "Local Area Connection" %local%
@echo off

rem Toggle Wireless
set "wireless="DISABLE"
netsh interface show interface name="Local Area Connection" | find /i "Disabled" > nul && set "wireless=ENABLE"
@echo on
netsh interface set interface "Wireless Network Connection" %wireless%
@echo off

netsh interface show interface

echo Process completed
pause
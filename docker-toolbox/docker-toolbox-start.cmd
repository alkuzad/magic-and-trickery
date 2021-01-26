@echo off

echo "Starting docker machine"
docker-machine start

docker-machine env 2>&1 | grep "error validating certificates"
if %ERRORLEVEL% == 0 (
    docker-machine regenerate-certs -f
)

echo "Setting up environment for docker machine connection"
:: This construct works only because powershell script sets variables in registry
:: using [Environment]::SetEnvironmentVariable with "User" flag
:: refresh-env.cmd will fetch these from registry and write to current cmd
powershell -command %~dp0\_powershell_imports\_docker_toolbox_setup.ps1
call %~dp0\refresh-env.cmd

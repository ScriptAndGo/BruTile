call dotnet build Tools\GetVersionFromAssembly\GetVersionFromAssembly.csproj /property:Configuration=Release
for /f "delims=" %%i in ('dotnet Tools\GetVersionFromAssembly\bin\Release\netcoreapp2.0\GetVersionFromAssembly.dll .\Release\netstandard1.1\BruTile.dll') do set VERSION=%%i
ECHO %VERSION%
msbuild brutile.sln /property:Configuration=Release
nuget push .\Release\brutile.%VERSION%.nupkg -source nuget.org
nuget push .\Release\brutile.mbtiles.%VERSION%.nupkg -source nuget.org
nuget push .\Release\brutile.desktop.%VERSION%.nupkg -source nuget.org
nuget push .\Release\brutile.desktop.DbCache.%VERSION%.nupkg -source nuget.org
git commit -m %VERSION% -a
git tag %VERSION%
git push origin %VERSION%
git push

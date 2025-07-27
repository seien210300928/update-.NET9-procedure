Remove-Item -Path "cfg.json" -Force
#删除老配置文件

Invoke-WebRequest -Uri "https://github.com/kwsch/PKHeX/archive/refs/heads/master.zip" -OutFile (Join-Path -Path $PWD -ChildPath "PKHeX.zip")
#克隆最新仓库到当前文件夹

Expand-Archive -Path .\PKHeX.zip -DestinationPath . -Force
#解压克隆文件

cd PKHeX-master
#进入克隆目录

dotnet clean
#清理构建缓存

dotnet publish PKHeX.WinForms/PKHeX.WinForms.csproj --configuration Release --runtime win-x64 /p:PublishSingleFile=true /p:IncludeNativeLibrariesForSelfExtract=true -o bin/MyOutput
#构建完整PKHeX.exe程序（未知原因，构建出的程序在任务栏没有图标）

Copy-Item -Path ".\bin\MyOutput\PKHeX.exe" -Destination ".."
#将构建好的PKHeX.exe复制到安装根目录

cd ..

Remove-Item -Path "PKHeX.zip" -Force
Remove-Item -Path "PKHeX-master" -Recurse -Force
#删除克隆文件

Pause
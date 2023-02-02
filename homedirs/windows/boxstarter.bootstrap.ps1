choco install git -y --source="'https://chocolatey.org/api/v2'" `
  --package-parameters='"/GitAndUnixToolsOnPath /WindowsTerminal"'

$Workspace = (Join-Path -Path $Env:USERPROFILE -Child workspace)
New-Item -ItemType "directory" -Path $Workspace -Force

git clone https://github.com/scottmuc/infrastructure.git $(Join-Path -Path $Workspace -ChildPath infrastructure)
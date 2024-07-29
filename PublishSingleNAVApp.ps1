& ' C:\Program Files\Microsoft Dynamics 365 Business Central\240\Service\NavAdminTool.ps1 '
# For BC14 use: import-module 'C:\Program Files\Microsoft Dynamics 365 Business Central\140\Service\Microsoft.Dynamics.Nav.Apps.Management.psd1'
$serverInstance = 'BC240'


$appPath = "C:\temp\myApp.app"
$app = Get-NavAppInfo -Path $appPath
Publish-NAVApp -ServerInstance $serverInstance -Path $appPath -SkipVerification
Sync-NAVApp -ServerInstance $serverInstance -Name $app.Name -Publisher $app.Publisher -Version $app.Version
Start-NAVAppDataUpgrade -ServerInstance $serverInstance -Name $app.Name -Publisher $app.Publisher -Version $app.Version
Install-NAVApp -ServerInstance $serverInstance -Name $app.Name -Publisher $app.Publisher -Version $app.Version 
$apps = Get-NAVAppInfo -ServerInstance $serverInstance -Name $app.Name | Where-Object Version -NE $app.Version
foreach($app in $apps){
    Uninstall-NAVApp -ServerInstance $serverInstance -Name $app.Name -Publisher $app.Publisher -Version $app.Version
    Unpublish-NAVApp -ServerInstance $serverInstance -Name $app.Name -Publisher $app.Publisher -Version $app.Version
}

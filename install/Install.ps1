#Get chocolatey
Set-ExecutionPolicy unrestricted
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
$env:Path += ";%systemdrive%\chocolatey\bin"
#Setup scheduled task
gcm -Module PSScheduledJob
$dailyTrigger = New-JobTrigger -Daily -At "2:00 PM"
Unregister-ScheduleJob -Name ChocolateyUpdate -Force
Register-ScheduledJob -Name ChocolateyUpdate -ScriptBlock {cup all} -Trigger $dailyTrigger
#install everything
choco install all -source https://raw.github.com/rikbrowning/RikChocolateySetup/master/packages/packages.config
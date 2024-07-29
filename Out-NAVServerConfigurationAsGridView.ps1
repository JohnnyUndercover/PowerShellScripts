Get-NAVServerConfiguration -ServerInstance BC240 | % {$_ | Select-Object } | Out-GridView

$alist = "Name`tAccountName`tDescription`tEmailAddress`tLastLogonDate`tManager`tTitle`tDepartment`tCompany`twhenCreated`tAcctEnabled`tGroups`n"
$userlist = Get-ADUser -Filter * -Properties * | Select-Object -Property Name,SamAccountName,Description,EmailAddress,LastLogonDate,Manager,Title,Department,Company,whenCreated,Enabled,MemberOf | Sort-Object -Property Name
$userlist | ForEach-Object {
    $grps = $_.MemberOf | Get-ADGroup | ForEach-Object {$_.Name} | Sort-Object
    $arec = $_.Name,$_.SamAccountName,$_.Description,$_.EmailAddress,$_LastLogonDate,$_.Manager,$_.Title,$_.Department,$_.Company,$_.whenCreated,$_.Enabled
    $aline = ($arec -join "`t") + "`t" + ($grps -join "`t") + "`n"
    $alist += $aline
}
$alist | Out-File C:\Scripts\ADUsers.csv

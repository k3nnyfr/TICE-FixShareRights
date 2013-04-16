Import-Module ShareUtils

$smb_serveur = "\\SERVEUR2008\"
$domaine = "stj"
$dc_domaine = "lan"
$ou_eleves = "ou=eleves,dc=$($domaine),dc=$($dc_domaine)"
$domaina = [ADSI]"LDAP://$($ou_eleves)"
$cpt = 0

$csv_users = Import-Csv .\fixeleves.csv

$log_result_create = ".\$(get-date -f yyyy-MM-dd-HH-mm) - FixEleves.csv"
"## Fichier de log - FixEleves - Execution du $current_time" >> $log_result_create

foreach ($line in $csv_users) 
{
	$cpt = $cpt+1
	$login = $line.Login
	$sharename = $login+"$"
	Write-Host "Operation en cours pour utilisateur $($login) - partage $($sharename)" >> $log_create_eleves
	Get-Share -Name $sharename | Add-SharePermission $login Allow FullControl | Set-Share >> $log_create_eleves
	$login = ""
	$sharename = ""
}

"Nombre d'éléments traités : $($cpt)"
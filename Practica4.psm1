function Ver-ReglasBloqueo{
    $reglas = Get-NetFirewallRule
    Write-Host "Reglas actuales"
    foreach($regla in $reglas){
        Write-Host "ID:" $regla.Name 
        Write-Host "Name:" $regla.DisplayName
        Write-Host "Estado:" $regla.Enabled
        Write-Host "Accion:" $regla.Action
    }
    if(Get-NetFirewallRule -Action Block -Enabled True -ErrorAction SilentlyContinue){
        Get-NetFirewallRule -Action Block -Enabled True
    } else{
        Write-Host "No hay reglas definidas"
    }
}
function Ver-StatusPerfil{
    param([Parameter(Mandatory)] [ValidateSet("Public", "Private")] [string] $perfil)
    $status = Get-NetFirewallProfile -Name $perfil
    Write-Host "Perfil: "$perfil
    if($status.enabled){
        Write-Host "Status: Activado"
    } else{
        Write-Host "Status: Desactivado"
    }
}
function Ver-PerfilRedActual{
    $perfilRed = Get-NetConnectionProfile
    Write-Host "Nombre de red: " $perfilRed.name
    Write-Host "Perfil de red: " $perfilRed.NetworkCategory
}
Ver-ReglasBloqueo|Ver-StatusPerfil|Ver-PerfilRedActual
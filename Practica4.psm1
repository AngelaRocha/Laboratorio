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
        Write-Host ""No hay reglas definidas
    }
}
function Agregar-ReglasBloqueo{
    $puerto = Read-Host -Promt "Cual puerto quieres bloquear?" 
    New-NetFirewallRule -DisplayName "Puerto-Entrada-$puerto" -Profile "Public" -Direction Inbound -Action Block -Protocol TCP -LocalPort $puerto
}
function Eliminar-ReglasBloqueo{
    $reglas = Get-NetFirewallRule -Action Block -Enabled True
    Write-Host "Reglas actuales"
    foreach($regla in $reglas){
        Write-Host "Regla:" $regla.DisplayName
        Write-Host "Perfil:" $regla.Profile
           Write-Host "ID:" $regla.Name
        $opc = Read-Host -Promt "Deseas eliminar esta regla? [Y] Si [N] No"
        if($opc -eq "Y"){
            Remove-NetFirewallRule -ID $regla.name
            break
        }
    }
}
Ver-ReglasBloqueo|Agregar-ReglasBloqueo|Eliminar-ReglasBloqueo
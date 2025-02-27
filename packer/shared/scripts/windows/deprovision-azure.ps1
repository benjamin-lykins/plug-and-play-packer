https://developer.hashicorp.com/packer/integrations/hashicorp/azure/latest/components/builder/arm#windows

foreach (
    $service in Get-Service -Name RdAgent, WindowsAzureTelemetryService, WindowsAzureGuestAgent -ErrorAction SilentlyContinue) {
    while (
        (
            Get-Service $service.Name).Status -ne 'Running'
    ) {
        Start-Sleep -s 5 
    } 
}

& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm
while ($true) {
    $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select-Object ImageState; if (
        $imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') {
        Write-Output $imageState.ImageState; Start-Sleep -s 10 
    }
    else { 
        break 
    } 
}
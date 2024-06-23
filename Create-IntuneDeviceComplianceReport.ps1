
# Configuration
$TenantId = "b2c216aa-fa15-418e-b330-d975d3188132"
$ClientId = "470c34a6-d414-4bfd-b362-49451e2c53c2"
$Secret = 

# Convert the secret to a secure string
$SecureSecret = ConvertTo-SecureString -String $Secret -AsPlainText -Force

# Create a credential object using the client ID and secure secret
$Credential = New-Object System.Management.Automation.PSCredential($ClientId, $SecureSecret)

# Connect to the Microsoft Graph API using the client ID, tenant ID, and credential object
Connect-MgGraph -TenantId $TenantId -ClientSecretCredential $Credential

# Get all Windows devices from Intune which are Entra ID Registred
$EntraIdDevices = Get-MgDevice -Filter "operatingSystem eq 'Windows' and profileType eq 'RegisteredDevice' and isManaged eq true and trustType eq 'Workplace'" -All

# Get primary User for each device
$EntraIdDevices | ForEach-Object {
    $Device = $_
    $PrimaryUser = Get-MgDevicePrimaryUser -DeviceId $Device.Id
    $Device.PrimaryUser = $PrimaryUser
}



# cadme_A020436@ksbcentral.onmicrosoft.com
# 2Sf4fg-yjRTibvI-x0ky-2RR-dK4gs9!
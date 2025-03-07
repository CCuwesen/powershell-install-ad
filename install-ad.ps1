Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Import-Module ADDSDeployment

Install-ADDSForest -DomainName "demo.local" -SafeModeAdministratorPassword (ConvertTo-SecureString "SecurePassw0rd!" -AsPlainText -Force) -Force

Start-Sleep -s 60

$users = @(
    @{ Name = "Alice Smith"; SamAccountName = "alice.smith"; UPN = "alice.smith@demo.local"; Password = "Xz4!rT9*Gm" },
    @{ Name = "Bob Miller";  SamAccountName = "bob.miller";  UPN = "bob.miller@demo.local";  Password = "Qw7@hK2#Zd" },
    @{ Name = "Charlie Doe"; SamAccountName = "charlie.doe"; UPN = "charlie.doe@demo.local"; Password = "Lm8^nY5!Vq" }
)

foreach ($user in $users) {
    $SecurePassword = ConvertTo-SecureString $user["Password"] -AsPlainText -Force
    New-ADUser -Name $user["Name"] `
               -SamAccountName $user["SamAccountName"] `
               -UserPrincipalName $user["UPN"] `
               -AccountPassword $SecurePassword `
               -PasswordNeverExpires $true `
               -Enabled $true
}

Restart-Computer -Force

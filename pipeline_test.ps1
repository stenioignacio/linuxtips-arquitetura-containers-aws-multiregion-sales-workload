Write-Host "INICIANDO ROLLOUT DO PRÉ-DEPLOYMENT"

Push-Location pre-deployment

Remove-Item -Path .terraform -Recurse -Force
terraform init -migrate-state -backend-config environment/backend.tfvars
terraform apply  -auto-approve -var-file environment/terraform.tfvars

Write-Host "FINALIZANDO ROLLOUT DO PRÉ-DEPLOYMENT"

Pop-Location

Write-Host "INICIANDO ROLLOUT DA REGIAO US-EAST-1"

Push-Location deployment

Remove-Item -Path .terraform -Recurse -Force
terraform init -migrate-state -backend-config environment/us-east-1/backend.tfvars
terraform apply  -auto-approve -var-file environment/us-east-1/terraform.tfvars

Write-Host "FINALIZANDO ROLLOUT DA REGIAO US-EAST-1"

Pop-Location

Write-Host "INICIANDO ROLLOUT DA REGIAO SA-EAST-1"

Push-Location deployment

Remove-Item -Path .terraform -Recurse -Force
terraform init -migrate-state -backend-config environment/sa-east-1/backend.tfvars
terraform apply  -auto-approve -var-file environment/sa-east-1/terraform.tfvars

Write-Host "FINALIZANDO ROLLOUT DA REGIAO SA-EAST-1"

Pop-Location

Write-Host "INICIANDO ROLLOUT DO POST-DEPLOYMENT"

Push-Location post-deployment

Remove-Item -Path .terraform -Recurse -Force
terraform init -migrate-state -backend-config environment/backend.tfvars
terraform apply  -auto-approve -var-file environment/terraform.tfvars

Write-Host "FINALIZANDO ROLLOUT DO POST-DEPLOYMENT"

Pop-Location
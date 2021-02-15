### repositório com itens utilizados na pós-graduação do SENAI/CTAI para provisionar recursos na AWS 

### entrar em cada pasta do terraform e relizar um terraform init 

```
terraform init
```

### para provisionar os ambientes, utilizar os comandos abaixo.
```
terraform apply --var-file=../../inventories/s3.tfvars -auto-approve
terraform apply --var-file=../../inventories/ec2.tfvars -auto-approve
terraform apply --var-file=../../inventories/rds.tfvars -auto-approve
```

### após validar, destruir os ambientes com os seguintes comandos
```
terraform destroy --var-file=../../inventories/s3.tfvars -auto-approve
terraform destroy --var-file=../../inventories/ec2.tfvars -auto-approve
terraform destroy --var-file=../../inventories/rds.tfvars -auto-approve
```
### repositório com itens utilizados na pós-graduação do SENAI/CTAI para provisionar recursos na AWS 

### primeiramente você precisa das tuas chaves da AWS exportadas localmente, caso não tenha pode usar os comandos abaixo para fazer
### caso você não saiba como gerar as chaves, utilizar o link abaixo para entender o processo 

[Criando credenciais AWS](https://docs.aws.amazon.com/pt_br/general/latest/gr/aws-sec-cred-types.html)


```
export AWS_ACCESS_KEY_ID=<seu ID de chave>
export AWS_SECRET_ACCESS_KEY=<sua chave>
export AWS_REGION=us-east-1
export AWS_DEFAULT_REGION=$AWS_REGION
```

### entrar em cada pasta do terraform e relizar um terraform init 

```
terraform init
```

### para provisionar os ambientes, utilizar os comandos abaixo.
```
terraform apply --var-file=../../inventories/s3.tfvars -auto-approve
terraform apply --var-file=../../inventories/ec2.tfvars -auto-approve
terraform apply --var-file=../../inventories/rds.tfvars -auto-approve
terraform apply --var-file=../../inventories/beanstalk.tfvars -auto-approve
```

### após validar, destruir os ambientes com os seguintes comandos
```
terraform destroy --var-file=../../inventories/s3.tfvars -auto-approve
terraform destroy --var-file=../../inventories/ec2.tfvars -auto-approve
terraform destroy --var-file=../../inventories/rds.tfvars -auto-approve
terraform destroy --var-file=../../inventories/beanstalk.tfvars -auto-approve
```
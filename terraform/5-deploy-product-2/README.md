## Where we at

Trying to use .tfvars files to overwrite defaults in variable.tf file to abstract the creation of instances.

HOWEVER, to fully complete the product, the public IP address of the db instance must be retrieved and put into the user data text in app_instance.tfvars

When fixed, executing the following commands:

```
terraform plan -var-file="db_instance.tfvars"
terraform apply -var-file="db_instance.tfvars"
```

```
terraform plan -var-file="app_instance.tfvars"
terraform apply -var-file="app_instance.tfvars"
```

should result in the desired outcome.

#### When using in the future, the user_data in app_instance.tfvars will need to have the export DB_HOST line added, but for now, app instance deployment using .tfvars works!

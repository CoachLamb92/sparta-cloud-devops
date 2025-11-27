# Terraform Commands

### terraform init

### terraform plan

- Compares the current terraform files to those saved in local tfstate
- Informs the user of creations, changes, and removals of resources

### terraform apply

- Executes the creations, changes and removals of resources found in the terraform plan step

### terraform destroy

- Systematically removes all resources saved in the local tfstate

### tfstate file

- This file contains all the current information regarding the resources created by terraform
- It can also contains sensitive information, such as private IDs and secret keys
- Therefore its file path must be written into a .gitignore file, so it doesn't become public when/if pushed to Github
- This is a challenge when working collaboratively, as a terraform plan execution could return lots of creations, zero removals and zero changes, as there would be no previous tfstate to compare it to

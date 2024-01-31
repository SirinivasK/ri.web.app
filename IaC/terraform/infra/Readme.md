##### to run the terraform first, create a workspace using the following commands:
terraform workspace new default (if not it already exists)
terraform workspace new graviton

###### run the below commands to create the default ec2 instance in aws
`terraform workspace select default
 terraform plan (o check the state)
 terraform apply (to create the infra)
 terrafrom destroy (to destroy the infra to save cost)
`
###### run the below commands to create the graviton ec2 instance in aws
`terraform workspace select graviton
 terraform plan (o check the state)
 terraform apply (to create the infra)
 terrafrom destroy (to destroy the infra to save cost)
`
### Note: we are using the auto.tfvars which will be automatically used when we switch the workspace
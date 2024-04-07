Prerequisites
---------
1. Export the bleow environment variables
    ```sh
    export AWS_ACCESS_KEY_ID="<your access key>"
    export AWS_SECRET_ACCESS_KEY="<your secret key>"
    export AWS_REGION="<region>"
    ```
2. Before deploying the infrastructure using Terraform, you must the generate key pair ```mykey``` in the targeted region
3. The file ````backend.tf```` has to be updated with the S3 backend configurations.
4. Certificates for your website need to be copied in to the ```Terraform/compute/certificates``` directory (with the names - server.crt and  server.key)
5. After completing the deployment, you need to add the cname record for your doamin to the alb dns name.
 
#### Execute the code

*  Clone the repository and change the directory to ```Terraform```
    The directories for identity and compute include the separate codes related to identity and compute, respectively. 
    You can execute the below terraform commands in ```compute``` and ```identity``` directories
    ```sh
    terraform init
    terraform plan
    terraform deploy
    ```
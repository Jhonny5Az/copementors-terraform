# Step 1: Create the S3 Bucket
# Step 2: Enable Versioning
# Step 3: Enable Server-Side Encryption
# Step 4: Block Public Access
# Step 5: Configure IAM Permissions
s3:ListBucket on the bucket
s3:GetObject and s3:PutObject on the state file
s3:GetObject, s3:PutObject, and s3:DeleteObject on the lock file (e.g., *.tflock)
# Step 6: Configure the Backend in Terraform
# Step 7: Migrate Your State
    terraform init

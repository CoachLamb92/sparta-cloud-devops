# AWS CLI Setup

### Install AWS CLI

`sudo apt install awscli`

### Check it works

`aws --version`

### Configure AWS access

`aws configure`

You should be prompted to enter the following details:

- AWS Access Key ID: YOUR_KEY_ID
- AWS Secret Access Key: YOUR_SECRET_KEY
- Default region name: eu-west-1
- Default output format: json

This will set up the two files for you. Go and check them, remember they are:

- ~/.aws/credentials
- ~/.aws/config

The contents of each should be as below:

**~/.aws/credentials**

```
[default]
aws_access_key_id = YOUR_KEY_ID
aws_secret_access_key = YOUR_SECRET_KEY
```

**~/.aws/config**

```
[default]
region = eu-west-1
output = json
```

### Verify Setup

Finally, check your connection to AWS via the terminal:

`aws sts get-caller-identity`

You should see output similar to the following:

```
{
"UserId": "AIDA....",
"Account": "123456789012",
"Arn": "arn:aws:iam::123456789012:user/your-user"
}
```

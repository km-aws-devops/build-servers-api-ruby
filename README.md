Use AWS CodeBuild to build an API written in Ruby to be deployed to servers

- The ```app``` folder contains an [API](app/lib/my_api.rb) written in Ruby (using Sinatra) built using a project in AWS CodeBuild
- A [CloudFormation template](template.yaml) provisions the following:
  - A git repository in AWS CodeCommit, 
  - the build project in AWS CodeBuild, 
  - and a build pipeline in AWS CodePipeline that triggers builds on changes to the ```develop``` branch in the repository   
    
- Pre-requisite: A service role for AWS CodePipeline must exist (usually created the first time the service is used, say, from the AWS Management Console) or can be created as follows:
  
```
$ cd iam
iam $ ./create_service_role.sh
  
```  
- Provision the CloudFormation stack as follows:

```
# Provision the CloudFormation stack
$ aws cloudformation create-stack \
    --stack-name develop-build-servers-api-ruby \
    --template-body file://template.yaml \
    --capabilities CAPABILITY_IAM

# Get the HTTP clone URL for the repository in CodeCommit
$ aws cloudformation describe-stacks \
    --stack-name develop-build-servers-api-ruby \
    --query "Stacks[0].Outputs[*].OutputValue" \
    --output text
https://git-codecommit.us-east-1.amazonaws.com/v1/repos/build-servers-api-ruby
    
```
- Once provisioned, the code artifacts in this repository are to be pushed to the repository in CodeCommit

```
# Configure credentials for an IAM user that has the privileges to push code to the repository in CodeCommit

$ export AWS_PROFILE=my-iam-user
$ git config credential.helper '!aws codecommit credential-helper $@'
$ git config credential.UseHttpPath true

# Use the HTTP clone URL obtained from the CloudFormation stack output
$ git remote add cc https://git-codecommit.us-east-1.amazonaws.com/v1/repos/build-servers-api-ruby
$ git remote -v
cc	https://git-codecommit.us-east-1.amazonaws.com/v1/repos/build-servers-api-ruby (fetch)
cc	https://git-codecommit.us-east-1.amazonaws.com/v1/repos/build-servers-api-ruby (push)
gh	git@github.com:km-aws-devops/build-servers-api-ruby.git (fetch)
gh	git@github.com:km-aws-devops/build-servers-api-ruby.git (push)

$ git branch
* develop
$ git push cc develop 

```

- Refer [documentation](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-https-unixes.html) for connecting to CodeCommit repositories using the AWS CLI credential helper
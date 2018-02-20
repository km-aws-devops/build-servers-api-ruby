Use AWS CodeBuild to build an API written in Ruby to be deployed to servers (with Elastic Beanstalk)

- The [```app```] folder contains an [API](app/lib/my_api.rb) written in Ruby (using Sinatra) built using a project in AWS CodeBuild
- A [CloudFormation template](template.yaml) provisions the following:
  - A git repository in AWS CodeCommit, 
  - the build project in AWS CodeBuild, 
  - and a build pipeline in AWS CodePipeline that triggers builds on changes to the ```develop``` branch in the repository   
- Provision the CloudFormation stack as follows:

```
$ aws cloudformation create-stack \
    --stack-name develop-build-servers-api-ruby \
    --template-body file://template.yaml \
    --capabilities CAPABILITY_IAM

```
- Once provisioned, the code artifacts in this repository are to be pushed to the repository in CodeCommit
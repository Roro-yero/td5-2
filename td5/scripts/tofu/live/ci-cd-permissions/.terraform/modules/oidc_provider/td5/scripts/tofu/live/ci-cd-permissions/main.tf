provider "aws" {
  region = "us-east-2"
}

module "oidc_provider" {
  source = "github.com/Roro-yero/td5-2//td5/scripts/tofu/modules/github-aws-oidc?ref=opentofu-tests"

  provider_url = "https://token.actions.githubusercontent.com" 

}

module "iam_roles" {
  source = "github.com/Roro-yero/td5-2//td5/cripts/tofu/modules/gh-actions-iam-roles?ref=opentofu-tests"

  name              = "lambda-sample"                           
  oidc_provider_arn = module.oidc_provider.oidc_provider_arn    

  enable_iam_role_for_testing = true                            

  # TODO: fill in your own repo name here!
  github_repo      = "Roro-yero/td5-2" 
  lambda_base_name = "lambda-sample"                            

  enable_iam_role_for_plan  = true                                
  enable_iam_role_for_apply = true                                

  # TODO: fill in your own bucket and table name here!
  tofu_state_bucket         = "fundamentals-of-devops-tofu-state" 
  tofu_state_dynamodb_table = "fundamentals-of-devops-tofu-state" 
}

This is a sample project structure for Onboarding 

The modules folder will contain the resource blocks which would create the actual resources.

The nonprod, qa and prod folders would contain are the environment specific folders. We will apply the code for each of these environments from the corresponding folders by running the terraform init/plan/apply commands.

The resource blocks will be called through the code inside these environment specific folders.

There is an GitHub Action created for applying the Terraform Code.

The content is only a base structure and would need further refinement.

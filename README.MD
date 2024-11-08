 # HOWDY

 Thank you for stopping by. This is a little pet project that I am attempting to modularize packer templates to make them as plug and play as possible. 

 Still a work in progress, but aiming for a minimally viable solution to quickstart packer adoption.  

 # Why

 I love Packer. Probably, too much. I also love Terraform. When it comes to anything from HashiCorp, I lean to the infrastructure side of things. 
 
 What I am tyring to do here is provide a resource to the community to more quickly adopt Packer and HCP Packer into their workloads.

 # Features

 ## Major Clouds

 At first this won't be too robust, but will allow for simple and practical methods to build images in the cloud. I will keep authentication mainly with a username + password, but I will link to documentation if looking to use alternative authentication. 

 For the major public clouds, I am referring to: 

 - AWS
 - Azure
 - GCP

 ## Plug and Play

 Looking to run this off of one Packer template. 

 One packer template which will build Linux and Windows images. 

 One Packer template which will build in a specific cloud platform or all the major platforms. 

 ## HCP Packer Integration

 Got HCP Packer? Good. 

 I will have a bool variable which can be set to true or false to start sending meta data to HCP Packer. 

 Bucket name and labels are customizable in the var-file. 
 
 ## Flexible

 I will try to leave this as flexible as possible. 

 When I think of flexibility I think of where to build, what to build, how to build. 

 Some examples and thoughts: 

 - Toggle to enable HCP Packer.
 - Toggle to override which cloud platforms to build on.
 - Specify the OS type : Linux or Windows which would then affect downstream build steps.
 - Var-Files which will be the preferred method to make this plug and play.
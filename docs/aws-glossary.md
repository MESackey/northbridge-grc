# AWS glossary (my own words)

## IAM
- What it is: IAM is how Northbridge will limit patient records to people who need them. Least-privilege RBAC is planned for R-004 but not yet in place.   
- One risk it reduces at Northbridge: At Northbridge, IAM directly reduces R-004 (Unauthorised staff viewing patient records) by enforcing least-privilege permissions so staff cannot view patient records outside their business scope - Role-Based Access Control (RBAC) 

## S3
- What it is: S3 is AWS's scalable online file storage service where data is organised into containers called buckets.
- What went wrong in R-001, and which setting prevents it: In R-001, a patient export sat in an exposed bucket accessible to anyone on the internet, a risk prevented by enabling the Block Public Access setting.

## VPC
- What it is: A VPC is an isolated, private virtual network inside AWS designed to secure infrastructure resources. 
- Why a database should not be directly reachable from the internet: Databases must sit in private subnets off the internet - like a locked back room - because direct exposure lets external attackers freely launch brute force or exploit attacks against stored data.

## CloudTrail
- What it is: CloudTrail is a timestamped record of actions taken in AWS, such as who created a bucket. 
- How it would help in R-004 (staff viewing patient records): For R-004 it helps with AWS-level access, but staff viewing patient records inside the app needs the app's own audit log. 
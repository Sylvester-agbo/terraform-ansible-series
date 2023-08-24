There are various modes of operation available with Ansible S3.

PUT: upload
GET: download
geturl: return download URL
getstr: download object as a string
list: list keys / objects
create: create bucket
delete: delete bucket
delobj: delete object
copy: copy object that is already stored in another bucket
For the aws_s3 module to work you need to have certain package version requirements

The below requirements are needed on the host that executes this module.

python >= 3.6
boto3 >= 1.15.0
botocore >= 1.18.0

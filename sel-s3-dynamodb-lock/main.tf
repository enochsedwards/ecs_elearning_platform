module "s3-bucket" {
    source    = "./s3-bucket"
    s3_prefix = "skillsedgelab"
    acl       = "private"

}

module "dynamodb-table" {
    source         = "./dynamodb-table"
    project_name   = "sel-e-learning"
    billing_mode   = "PROVISIONED"
    hash_key       = "LockID"
    type           = "S"
    read_capacity  = 20
    write_capacity = 20
    

}
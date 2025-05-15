terraform {
    backend "s3" {
        bucket = "somethingelse123"
        key = "tfstate/state"
        region = "us-east-1"
    }
}
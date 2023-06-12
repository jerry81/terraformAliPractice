provider "alicloud" {
  region       = "cn-shanghai"
}
resource "alicloud_log_project" "example" {
  name        = "tf-log"
  description = "created by terraform"
  tags        = { "test" : "test" }
}
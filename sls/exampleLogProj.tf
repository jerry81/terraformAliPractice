provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_log_project" "staging" {
    description = "CNSHSLS001002"
    name        = "k8s-log-ce1d89e1ffb644a42ad94a226e5e8aa52"
    tags        = {
        "ack.aliyun.com" = "ce1d89e1ffb644a42ad94a226e5e8aa52"
    }

    timeouts {}
}

resource "alicloud_log_project" "production" {
    description = "CNSHSLS001001"
    name        = "k8s-log-cfbfd43a3637d47a3ad079bcb0557a275"
    tags        = {
        "ack.aliyun.com" = "cfbfd43a3637d47a3ad079bcb0557a275"
    }

    timeouts {}
}
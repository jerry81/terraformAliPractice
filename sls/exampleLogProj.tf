provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_log_project" "staging" {
    # id          = "k8s-log-ce1d89e1ffb644a42ad94a226e5e8aa52"
    description = "CNSHSLS001002"
    name        = "k8s-log-ce1d89e1ffb644a42ad94a226e5e8aa52"
    tags        = {
        "ack.aliyun.com" = "ce1d89e1ffb644a42ad94a226e5e8aa52"
    }

    timeouts {}
}

resource "alicloud_log_project" "production" {
    description = "CNSHSLS001001"
    # id          = "k8s-log-cfbfd43a3637d47a3ad079bcb0557a275"
    name        = "k8s-log-cfbfd43a3637d47a3ad079bcb0557a275"
    tags        = {
        "ack.aliyun.com" = "cfbfd43a3637d47a3ad079bcb0557a275"
    }

    timeouts {}
}

resource "alicloud_log_store" "onesubscription-staging" {
    append_meta           = true
    auto_split            = true
    enable_web_tracking   = false
    hot_ttl               = 0
    # id                    = "k8s-log-ce1d89e1ffb644a42ad94a226e5e8aa52:onesubscription"
    max_split_shard_count = 64
    mode                  = "standard"
    name                  = "onesubscription"
    project               = "k8s-log-ce1d89e1ffb644a42ad94a226e5e8aa52"
    retention_period      = 180
    shard_count           = 2
    # shards                = [
    #     {
    #         begin_key = "00000000000000000000000000000000"
    #         end_key   = "80000000000000000000000000000000"
    #         id        = 0
    #         status    = "readwrite"
    #     },
    #     {
    #         begin_key = "80000000000000000000000000000000"
    #         end_key   = "ffffffffffffffffffffffffffffffff"
    #         id        = 1
    #         status    = "readwrite"
    #     },
    # ]

    timeouts {}
}

resource "alicloud_logtail_config" "onesubscription-staging" {
    # id           = "k8s-log-ce1d89e1ffb644a42ad94a226e5e8aa52:onesubscription:kubernetes-stdout-config-ngxjnkaw"
    input_detail = jsonencode(
        {
            adjustTimezone  = false
            delayAlarmBytes = 0
            discardNonUtf8  = false
            enableRawLog    = false
            enableTag       = false
            filterKey       = []
            filterRegex     = []
            localStorage    = true
            logTimezone     = ""
            maxSendRate     = -1
            mergeType       = "topic"
            plugin          = {
                global = {
                    AlwaysOnline = true
                    type         = "k8sStdout"
                }
                inputs = [
                    {
                        detail = {
                            IncludeK8sLabel = {
                                app = "onesubscription"
                            }
                            Stderr          = true
                            Stdout          = true
                        }
                        type   = "service_docker_stdout"
                    },
                ]
            }
            priority        = 0
            sendRateExpire  = 0
            sensitive_keys  = []
            shardHashKey    = []
        }
    )
    input_type   = "plugin"
    logstore     = "onesubscription"
    name         = "kubernetes-stdout-config-ngxjnkaw"
    output_type  = "LogService"
    project      = "k8s-log-ce1d89e1ffb644a42ad94a226e5e8aa52"
}

resource "alicloud_log_machine_group" "staging" {
    # id            = "k8s-log-ce1d89e1ffb644a42ad94a226e5e8aa52:k8s-group-ce1d89e1ffb644a42ad94a226e5e8aa52"
    identify_list = [
        "k8s-group-ce1d89e1ffb644a42ad94a226e5e8aa52",
    ]
    identify_type = "userdefined"
    name          = "k8s-group-ce1d89e1ffb644a42ad94a226e5e8aa52"
    project       = "k8s-log-ce1d89e1ffb644a42ad94a226e5e8aa52"
}

resource "alicloud_logtail_attachment" "onesubscription-to-staging" {
    # id                  = "k8s-log-ce1d89e1ffb644a42ad94a226e5e8aa52:kubernetes-stdout-config-ngxjnkaw:k8s-group-ce1d89e1ffb644a42ad94a226e5e8aa52"
    logtail_config_name = "kubernetes-stdout-config-ngxjnkaw"
    machine_group_name  = "k8s-group-ce1d89e1ffb644a42ad94a226e5e8aa52"
    project             = "k8s-log-ce1d89e1ffb644a42ad94a226e5e8aa52"
}
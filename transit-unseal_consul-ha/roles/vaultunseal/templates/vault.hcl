listener "tcp" {
  address          = "0.0.0.0:8200"
  cluster_address  = "192.168.77.2:8201"
  tls_disable      = "true"
}

storage "inmem" {}
disable_mlock = true

api_addr = "http://192.168.77.2:8200"
cluster_addr = "https://192.168.77.2:8201"

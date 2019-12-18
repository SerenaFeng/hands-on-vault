listener "tcp" {
  address          = "0.0.0.0:8200"
  cluster_address  = "192.168.77.5:8201"
  tls_disable      = "true"
}

storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault-unseal/"
}

seal "transit" {
  address            = "http://192.168.77.2:8200"
  token              = "s.8Vn1i6I9fa89hU4dgrR37zkW"
  disable_renewal    = "false"

  // Key configuration
  key_name           = "unseal_key"
  mount_path         = "transit/"
}

api_addr = "http://192.168.77.5:8200"
cluster_addr = "https://192.168.77.5:8201"

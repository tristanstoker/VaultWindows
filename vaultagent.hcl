vault {
  address = "https://vault-cluster-public-vault-9ce01a1f.def65bf3.z1.hashicorp.cloud:8200"
}

exit_after_auth = true

auto_auth {
  method "token_file" {
    config = {
      token_file_path   = "C:/vaultagent/agent-token"
    }
  }
}

cache {
  use_auto_auth_token = true
}

listener "tcp" {
  address     = "127.0.0.1:8100"
  tls_disable = true
}


template {
  source      = "C:/vaultagent/dynamic-cert.tpl"
  destination = "C:/vaultagent/cert.txt"

  exec {
  command = "C:/vaultagent/callpsscript.bat"
}

}

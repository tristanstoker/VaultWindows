{{ with pkiCert "example-pki/issue/my-first-vault-cert" "common_name=foo.example.com" "ttl=3m" }}
{{ .Data.Key }}
{{ .Data.Cert }}
{{ .Data.CA }}
{{ end }}

# Vault Agent on Windows
> PKI

## Usecase
In this example we are configuring Vault Agent on windows to consume certificates. HashiCorp Vault delivers certficates in PKCS#1/PEM format, and Windows requires PKCS#12/PFX so we will
need to convert our certificate/keys using openssl. There is a native utility on Windows called CertUtil, however it will not convert PKCS#1 to PKCS#12. Once openssl has converted our 
PEM bundle to PFX, we will use Import-PfxCertificate to add the certificate to the Windows Certificate Store.

## Vault Agent Configuration
1. Define your Vault Cluster as shown in the example vaultagent.hcl.
2. Configure Auto-Auth with your preferred Auth Method. This link will take you to the documentation on Auto-Auth along with an approle example, however if you continue through the
   documentation there are examples for a dozen or so other authentication methods.
   - [Vault Auto-Auth Documentation](https://developer.hashicorp.com/vault/docs/agent-and-proxy/autoauth)
4. Configure Vault Agent Caching.
   - [Vault Agent Caching](https://developer.hashicorp.com/vault/tutorials/vault-agent/agent-caching)
5. Define the listener on the Vault Agent.
6. Define the Vault Agent Template. Vault Agent Templates are used to define which secrets engine, along with how Vault Agent will be interacting with that secret engine.
   - [Vault Agent Template](https://developer.hashicorp.com/vault/docs/agent-and-proxy/agent/template)
7. Configure Vault Agent Exec. Vault Agent Exec has the capability to run commands and execute scripts after a new secret has been consumed. In this usecase once a new pem bundle is
   retrieved by Vault, Vault Agent Exec will run a batch script (callpsscript.bat) which will run our (script2.ps1) powershell script to convert the format of our PEM bundle to PFX.
   the powershell script will then import the certificate to the Windows Certificate Store. I've included the batch script as it can be a little tricky having Vault Agent run powershell
   directly. If I get this worked out I will update the configuration.



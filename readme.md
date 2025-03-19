cd nginx-custom
docker build -t lhc-hello-app:latest .

minikube image load lhc-hello-app:latest


brew install gnupg

brew install sops

export SOPS_PGP_FP="$(gpg --generate-key --batch <<EOF
%no-protection
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: Helm Secrets
Name-Email: helm-secrets@example.com
Expire-Date: 0
EOF
)"

gpg --list-keys

sops --encrypt secrets/dev.secrets.yaml > secrets/dev.secrets.yaml.enc

sops --encrypt secrets/stage.secrets.yaml > secrets/stage.secrets.yaml.enc

ver contenido de secreto:
sops secrets/dev.secrets.yaml.enc
helm secrets decrypt secrets/dev.secrets.yaml.enc

desencryptar para editarlo:
helm secrets decrypt secrets/stage.secrets.yaml.enc > secrets/stage.secrets.yaml
sops --encrypt --output secrets/stage.secrets.yaml.enc secrets/stage.secrets.yaml


helmfile -e dev apply
helmfile -e stage apply

helm uninstall hello-app 

minikube service hello-app --url

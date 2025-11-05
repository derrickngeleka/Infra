build {
  sources = ["source.azure-arm.vm"]

  # Provision with bash (robust apt update + installs)
  provisioner "shell" {
    inline_shebang = "/bin/bash -e"
    inline = [
      "set -o pipefail",
      "export DEBIAN_FRONTEND=noninteractive",

      # Use Azure's Ubuntu mirror (harmless if already correct)
      "sudo sed -i 's|http://[^ ]*archive.ubuntu.com|http://azure.archive.ubuntu.com|g' /etc/apt/sources.list || true",

      # Retry apt-get update a few times (mirrors can flake)
      "for i in {1..5}; do sudo apt-get update && break; echo \"apt-get update failed, retry $i\"; sleep 10; done",

      # Install essentials (no recommends to keep image slim)
      "sudo apt-get install -y --no-install-recommends ca-certificates curl unzip jq net-tools",

      # Quick sanity check
      "unzip -v >/dev/null 2>&1 || (echo 'unzip not installed' && exit 1)",
      "jq --version >/dev/null 2>&1 || (echo 'jq not installed' && exit 1)"
    ]
  }

  # Deprovision/clean before capture
  provisioner "shell" {
    inline_shebang = "/bin/bash -e"
    inline = [
      "set -o pipefail",
      "sudo /usr/sbin/waagent -force -deprovision+user || true",
      "export HISTSIZE=0 && sync"
    ]
    only = ["azure-arm"]
  }
}

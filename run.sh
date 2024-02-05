#!/bin/bash

# Check if DO_API_TOKEN and MACHINE_KEY_DO_FINGERPRINT are set
[ -z "$DO_API_TOKEN" ] && echo "Error: DO_API_TOKEN environment variable is not set." && exit 1
[ -z "$MACHINE_KEY_DO_FINGERPRINT" ] && echo "Error: MACHINE_KEY_DO_FINGERPRINT environment variable is not set." && exit 1

# Check if ~/.ssh/machine and ~/.ssh/machine.pub files exist
[ ! -f "$HOME/.ssh/machine" ] && echo "Error: ~/.ssh/machine file does not exist." && exit 1
[ ! -f "$HOME/.ssh/machine.pub" ] && echo "Error: ~/.ssh/machine.pub file does not exist." && exit 1

echo "All checks passed. Environment variables are set, and SSH key files exist."

# Function to check if a command is available
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install Homebrew (if not installed)
if ! command_exists brew; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install Ansible using Homebrew
if ! command_exists ansible; then
  echo "Installing Ansible..."
  brew install ansible
fi

# Install the community.digitalocean Ansible collection
if ! ansible-galaxy collection list | grep -q community.digitalocean; then
  echo "Installing community.digitalocean Ansible collection..."
  ansible-galaxy collection install community.digitalocean
fi

# Install doctl using Homebrew
if ! command_exists doctl; then
  echo "Installing doctl..."
  brew install doctl
fi

# Print completion message
echo "Setup complete. You can now run your Ansible playbook."

ansible-playbook deploy.yml
./update-dns.sh
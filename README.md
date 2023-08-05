# focus

My current learning focus.


<br />

# Create config file for major vendors

cat << EOF > ~/.ssh/config
Host git-codecommit.*.amazonaws.com
  User <INSERT STRING FROM AWS HERE>
  IdentityFile ~/.ssh/id_rsa
  PubkeyAcceptedAlgorithms +ssh-rsa
  HostkeyAlgorithms +ssh-rsa

Host ssh.dev.azure.com
  IdentityFile ~/.ssh/id_rsa
  PubkeyAcceptedAlgorithms +ssh-rsa
  HostkeyAlgorithms +ssh-rsa

Host source.developers.google.com
  IdentityFile ~/.ssh/id_rsa
  PubkeyAcceptedAlgorithms +ssh-rsa
  HostkeyAlgorithms +ssh-rsa

Host github.com
  User git
  Hostname github.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_rsa
EOF

<br />

# Git Setup

  git config --global user.email "you@example.com"
  git config --global user.name $USER

<br />

# Installs

sudo apt install wine git nano htop build-essential neofetch
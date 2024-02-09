#!/bin/bash

echo "------------Azure agent startup script------------"

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root or use sudo."
    exit 1
fi

# Set the username and password
USERNAME=mark
PASSWORD=password

# Check if the user already exists
if id "$USERNAME" &>/dev/null; then
    echo "User $USERNAME already exists."
    exit 1
fi

# Create the user with a specific password
useradd -m "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd

# Switch to the new user

su - "$USERNAME"


su -c "
echo '--------User id--------'
id

cd /home/$USERNAME

echo 'Downloading azure linux agent'

wget https://vstsagentpackage.azureedge.net/agent/3.232.3/vsts-agent-linux-x64-3.232.3.tar.gz

mkdir mark-agent

cd mark-agent/

tar zxvf /home/$USERNAME/vsts-agent-linux-x64-3.232.3.tar.gz

./config.sh --unattended --url https://dev.azure.com/Akatsuki-org --auth pat --token k4t4ke326iscfwvg545ib6yic3mxubcnktuks27ins7cxg3q3e4q --pool my-custom-pool --agent agent-mark

./run.sh

" $USERNAME

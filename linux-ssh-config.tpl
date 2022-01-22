cat << EOF >> ~/.ssh/config

Host ${hostname}
    HostName ${hostname}
    User ${username}
    IdentityFile ${identity_file}
EOF
#!/bin/sh
cat <<EOF > creds
#!/bin/sh
echo protocol=https
echo host=github.com
echo username=foo
echo password=${GITHUB_PERSONAL_ACCESS_TOKEN}
EOF
sudo install creds /usr/local/bin/creds
#git config --global credential.helper "creds"
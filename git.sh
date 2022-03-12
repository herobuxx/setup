#!/bin/bash

echo "Please enter your Git Username"
read -r gituser
git config --global user.user ${gituser}

echo "Please enter your Git E-Mail"
read -r gitmail
git config --global user.email ${gitmail}

echo "Did you want to setup GPG Keys for signing commits? [y/n]"
read -r setgpg
if [[ "${setgpg}" == "y" ]];
then
  gpg --gen-key
  KEY_ID="$(gpg --list-secret-keys --keyid-format LONG ${gitmail} | grep sec | awk '{print $2}' | sed 's/rsa3072\///')"
  git config --global user.signingkey ${KEY_ID}
  gpg --armor --export ${KEY_ID} | 
  git config --global commit.gpgsign true
  echo "export GPG_TTY=\$(tty)" >> ~/.bashrc
else
  echo "Skipping this step"
fi

echo "Done!"

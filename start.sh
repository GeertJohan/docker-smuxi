#! /bin/sh


user=${USERNAME-admin}
pass=${PASSWORD-admin}

if smuxi-server --list-users | grep -Fxq "$user"
  then
  echo "User already exists."
else
  smuxi-server --add-user --username=$user --password=$pass
fi

smuxi-server

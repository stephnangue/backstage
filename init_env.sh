source $HOME/env/bin/activate
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa
ssh-add ~/.ssh/sabr.private
ssh-add -L
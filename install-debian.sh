/usr/bin/bash
CWD_DIR="$(cwd)"

sudo apt-get install stow wget git

cd /tmp
wget https://git.savannah.gnu.org/cgit/guix.git/plain/etc/guix-install.sh
sudo chmod +x guix-install.sh
sudo ./guix-install.sh
cd "$CWD_DIR"

cd ./configs
stow * -t $HOME --adopt # adopt to make sure files are symlinked
cd ..

git reset --hard # restore adopted files

mkdir -p $HOME/git/
cp ./configs-root/ $HOME/git/ -r
cd "$HOME/git/"
cd ./configs-root/
sudo stow * -t /
cd ..

sudo chown -R root ./configs-root/ # Set the proper permissions.

cd "$CWD_DIR"

guix pull # for new channels
sudo guix archive --authorize < /etc/signing-key.pub
guix package -m ~/.guix-manifest-tiny

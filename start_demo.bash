#!/bin/bash
echo "Hi $USER, lets go!"

SCRIPT=$(readlink -f $0) #Absolute path -> script
location=`dirname $SCRIPT` # Absolute path -> Ordner

queue="/tmp/dateien.liste"

log="$location/ErrorMsg.log"

echo "Please Enter your Username and push [Enter]"

read username

su -c "touch $log" $username

touch /tmp/dateien.liste

echo "/usr/bin/apt-get install sqlite3 -y" >> /tmp/dateien.liste
echo "/usr/bin/apt-get install vim -y" >> /tmp/dateien.liste
echo "/usr/bin/apt-get install python -y" >> /tmp/dateien.liste
echo "/usr/bin/apt-get install python3 -y">> /tmp/dateien.liste
echo "/usr/bin/apt-get install curl -y" >> /tmp/dateien.liste
echo "/usr/bin/apt install ssh-askpass -y" >> /tmp/dateien.liste
echo "/usr/bin/curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py"	>> /tmp/dateien.liste
echo "/usr/bin/python get-pip.py" >> /tmp/dateien.liste
echo "/usr/local/bin/pip install -U pip"  >> /tmp/dateien.liste
echo "/usr/bin/apt-get install git -y" >> /tmp/dateien.liste
echo "/usr/bin/apt-get install intellij-idea-community -y" >> /tmp/dateien.liste

#Django Spezifisch
echo "/usr/local/bin/pip install Django" >> /tmp/dateien.liste

while read line
do
   echo -n "."
   eval "$line" &>> $log
   echo "===========================" >> $log
done < /tmp/dateien.liste
echo " "
rm ./get-pip.py
rm /tmp/dateien.liste

echo "Clone Gesamtes Git RePo"

su -c "touch ~/startGit.txt" $username

echo "#!/bin/bash" > ~/startGit.txt
echo "git config --global user.name '$username' &>> $log " >> ~/startGit.txt
echo "git config --global user.email '$username@your.EMail.de' &>> $log " >> ~/startGit.txt
echo "ssh-keyscan github.com >> ~/.ssh/known_hosts &>> $log " >> ~/startGit.txt
echo "ssh -T git@github.com &>> $log" >> ~/startGit.txt
echo "git clone https://github.com/NadixBA/DjangoDemo.git" >> ~/startGit.txt

su -c "bash ~/startGit.txt" $username

rm -rf ~/startGit.txt

exit 0

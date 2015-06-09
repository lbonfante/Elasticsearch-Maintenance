#/bin/bash
#Delete History Elasticsearch
clear
red=$(tput setaf 1)
green=$(tput setaf 2)
NC=$(tput sgr0)

echo -e "\n\n${green}     ELASTICSEARCH TASK: DELETE OLDER LOGS ${NC}\n\n"
echo -e 'This script create a daily task in crontab to execute an eraser of logs or index'
echo -e 'older than the number of days you want to delete. Therefore you can prevent disk space overload.\n'
echo -e 'You can modificate this script to make a delete every month or whatever you want.\n\n'


#Instalando requisitos
sudo apt-get install python-pip
pip install elasticsearch-curator

#ubicacion de curator: /usr/local/bin/curator
prog1=$(which curator)

read -p "Do you want to delete indices older than [days]: ${green}" delday 

if [ $delday -gt 0 ]; then 
	read -p "${NC}Are you sure that you want to delete indices older than ${red}$delday${NC} days (Y to continue)? ${green}" cont

	if [ "Y" != "$cont" ]; then
	 	echo -e "${red}Abort Mision.\n${NC}"
	else
		echo -e "\n\n${NC}If you want to undo the changes just delete the last line in ${red}'sudo crontab -e'${NC}"
		echo "or restore backup file ${red}'sudo crontab crontab.backup'${NC} in ${red}$(pwd)${NC} directory."
		#backup of current crontab
		sudo crontab -l > crontab.backup
		sudo crontab -l > newcron
		#add task to cronfile
		echo "@daily $prog1 --host 127.0.0.1 delete indices --older-than $delday --time-unit days --timestring %Y.%m.%d" >> newcron
		#write new cron file
		sudo crontab newcron
		echo -e "\n${green}The lastest tasks of your new crontab file are:${NC}\n"
		tail -5 newcron
		echo -e "\nYou can mod this task with ${red}'sudo crontab -e'.${NC}\n"
		rm newcron
	fi
else
	echo -e 'Error: you have to enter a value greater than zero.\n'
fi

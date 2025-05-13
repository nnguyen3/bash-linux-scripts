
### Make this a bash script that can be executed by putting
### a "shebang" at the top of the file

### Execute command that prints every command as it is executed

### (1) In your home directory make a directory called RAW_DATA
#!/bin/bash
echo "It works!"
mkdir ~/RAW_DATA
### (2) Copy all .fna fasta files  
###     from home directory into RAW_DATA (must work from any directory.)
cp ~/*.fna ~/RAW_DATA/  # * = all  
### (3) Do the same with all primer files ending with .csv
cp ~/*.csv ~/RAW_DATA/
### (4) In your home directory, make 2 directories: P_DATA and RESULTS
mkdir ~/P_DATA ~/RESULTS
### (5) Add all three directories to your $PATH: ~/RAW_DATA, ~/P_DATA
###     and ~/RESULTS
export PATH=$PATH:~/RAW_DATA
export PATH=$PATH:~/P_DATA
export PATH=$PATH:~/RESULTS
### (6) Write your entire $PATH, the name RAW_DATA and the 
###    contents of this directory (the names of the files) into a new file 
###    called 'readme.txt' in your home directory
echo "PATH: $PATH" > ~/readme.txt  #write entire path to readme.txt in home directory
echo "~/RAW_DATA" >> ~/readme.txt  #write context of raw data directory into readme.txt
ls ~/RAW_DATA >> ~/readme.txt
### (7) The last command should dump the contents of readme.txt
###     to the terminal.

echo "Content of readme.txt"
cat ~/readme.txt
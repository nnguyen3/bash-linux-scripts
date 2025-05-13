#! /bin/bash

### Run this script from within the RAW_DATA folder which should be in your home directory (~/RAW_DATA)
### Inside this directory should be this script AND the fasta file bigdata.fna

### NOTE THAT SECTIONS (1) and (2) HAVE ALREADY BEEN COMPLETED. 

### (1) Ask the user for a fasta file for analysis. The following command, read, reads in user input from the command line.
###     For this exercise, use the file bigdata.fna which should be in your file ~/RAW_DATA

#ask for fasta file
read -p "Enter fasta filename: " fn

### (2) Check to see if the file exists. If not, the function exits. I modified this if/then statement from the internet.

if [[ ! -f ./"bigdata.fna" ]]; then
   echo "$fn does not exist. Exiting..."
   exit 1
fi



### (3) Split up the bigdata.fna into separate smaller .fna files of 50,000 sequences each.
###
###     I got the following line of code below from the internet. You will need to modify this awk command.
###     'awk' is a programming language for shell scripting for working with files.
###
###     Currently, the awk command splits a fasta file into smaller files of just 1000 sequence each. We want 50000.
###
###     The other problem is that it works on the wrong file. Change it so that it works with the user input file (see echo above).
###     Change these things and you should get 3 to 4 output files starting with 'myseq'



#this is to make the bigdata.fns to smaller file
awk 'BEGIN {n_seq=0;} /^>/ {if(n_seq%1000==0){file=sprintf("myseq%d.fa",n_seq);} print >> file; n_seq++; next;} { print > file; }' < "fn"


### (4) Use grep to check how many fasta sequences are in all of the .fna files and redirect this to a file in RAW_DATA called 'log.txt'
###     Hints on grep: -c counts and you can grep multiple files at once using the *. 

grep -c ">" my*fna > log.txt   #how many fasta file in .fna and put this into log.txt

### (5) Dump the output of log.txt to the terminal 
echo "Output of log.txt:"
cat log.txt


### (6) The for loop below cycles though every file in the current directory and prints them.
###     The awk script below removes all the line breaks from fasta files.
###     TASK: Change the for loop so that it runs the awk command on all of the my*fna files and
###           outputs a new file with a .txt extension.
###     HINT: put the awk inside the do loop; also you can add extensions by $f'.txt' - this added a .txt to every $f file.

### More information on for loops can be found at: https://www.cyberciti.biz/faq/bash-loop-over-file/

for f in my*fna
do
    echo "Processing $f" #do something on file
    awk 'BEGIN{RS=">"}{gsub("\n","",$0); print ">"$0}' myseq50000.fna > myseq50000.fna.txt  

done

### (7) Use a for loop to count all the instances of the following string in all of the .fna.txt files:
###     'CACCCTCTCAGGTCGGCTACGCATCGTCGCC'
###     Also, like in (4) have the grep results for all files appended to log.txt (DON'T OVERWRITE IT)
###       then show the contents of log.txt in the terminal

for fn in my*fna.txt
do
    echo "Count all the instance in $fn"
    grep -o "CACCCTCTCAGGTCGGCTACGCATCGTCGCC" "$fn" >> log.txt  # -o is to only prints the part of the line that matches the pattern
    echo "$fn" >> log.txt
done


### (8) Move all the .fna.txt files to the directory ~/P_DATA

mkdir ~/P_DATA
mv my*fna.txt ~/P_DATA/

### (9) Make a tar of the files in P_DATA - call it pdata.tar
tar -cf ~/P_DATA/pdata.tar ~/P_DATA


### (10) Compress pdata.tar
gzip ~/P_DATA/pdata.tar




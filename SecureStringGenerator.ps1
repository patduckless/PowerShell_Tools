# This needs to be run in the user instance and on the machine it will be used on. 

read-host -assecurestring | convertfrom-securestring | out-file C:\mysecurestring.txt

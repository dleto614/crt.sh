#!/usr/bin/env bash

DOMAIN=""
COMPANY=""
OUTPUTFILE=""
	
usage() {  # Function: Print a help message.
  echo "Usage: $0 [ -d DOMAIN TO CHECK IN CRT.SH ] [ -c ORGANIZATION/COMPANY NAME TO CHECK IN CRT.SH ] [ -o OUTPUTFILE TO SAVE RESULTS ] [ -h HELP ]" 1>&2
}

exit_abnormal() { # Function: Exit with error.
  usage
  echo "---------------"
  echo "Exiting!"
  exit 1
}

# Request the Search  with Domain Name
domain_lookup() {
	requestsearch="$(curl -s "https://crt.sh?q=$DOMAIN&output=json")"
	echo $requestsearch | jq ".[].common_name,.[].name_value"| cut -d'"' -f2 | sed 's/\\n/\n/g' | sed 's/\*.//g'| sed -r 's/([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4})//g' | sort -u
}		 

# Request the Search with Organization Name
company_lookup() {
	requestsearch="$(curl -s "https://crt.sh?q=$COMPANY&output=json")"
	echo $requestsearch | jq ".[].common_name"| cut -d'"' -f2 | sed 's/\\n/\n/g' | sed 's/\*.//g'| sed -r 's/([A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4})//g' | sort -u
}

while getopts "d:o:c:h" opt
do
	case ${opt} in
		h) # display Help
			exit_abnormal
			;;
		d) # Search Domain Name
			DOMAIN="${OPTARG}"
			;;
		c) # Search Organization Name
		    COMPANY="${OPTARG}"
			;;
		o) # Output file
			OUTPUTFILE="${OPTARG}"
			;;
	esac
done

if [[ -n "$DOMAIN" ]]
then
	#echo "[*] Checking $DOMAIN on crt.sh"
	#echo "---------------"

	# Outputfile is optional
	if [[ "$OUTPUTFILE" ]]
	then
		domain_lookup $DOMAIN > $OUTPUTFILE
	else
		domain_lookup $DOMAIN
	fi
elif [[ -n "$COMPANY" ]]
then
	#echo "[*] Checking $COMPANY on crt.sh"
	#echo "---------------"

	# Outputfile is optional
	if [[ "$OUTPUTFILE" ]]
	then
		company_lookup $COMPANY > $OUTPUTFILE
	else
		company_lookup $COMPANY
	fi
else
	echo "[!] Not all required arguments were supplied"
	echo "---------------"
	exit_abnormal
	exit
fi

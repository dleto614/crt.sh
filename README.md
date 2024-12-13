# crt.sh
My own implantation of crt.sh script that I found, but found it to be inadequate so I added my own stuff to it.

------

Help:

```bash
Usage: ./crt.sh [ -d DOMAIN TO CHECK IN CRT.SH ]
[ -c ORGANIZATION/COMPANY NAME TO CHECK IN CRT.SH ]
[ -o OUTPUTFILE TO SAVE RESULTS ]
[ -h HELP ]
```

Examples of usage:

```bash
./crt.sh -d google.com -o google-domains.txt
```

------

Very simple to use. You can pipe the output to something like httprobe.

Example:

```bash
$ ./crt.sh -d google.com | httprobe | tee -a  google-http-sites.txt
...
https://upload.google.com
https://upload.video.google.com
http://webdrive-test-canary.corp.google.com
http://webdrive-test-prod.corp.google.com
https://webdrive-test-canary.corp.google.com
https://webdrive-test-prod.corp.google.com
http://wifi.google.com
http://www.google.com
https://wifi.google.com
https://www.google.com
```

----

!#/bin/sh

filename=$FILENAME
password=$PASS
sftp_uri=$SFTP_URI
sftp_port=$SFTP_PORT

/usr/bin/expect<<EOD
spawn sftp -P $sftp_port -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" $sftp_uri
expect "($sftp_uri) Password:"
send "$password\r"
expect "sftp>"
send "get /sftp/input/$filename work.DCM\r"
expect "sftp>"
send "bye\r"
EOD

mkdir -p out

java -jar dicom-edit6-1.0.8-SNAPSHOT-jar-with-dependencies.jar -s dicomedit_scripts/anonymization.des -i work.DCM -o out


/usr/bin/expect<<EOD
spawn sftp -P $sftp_port -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" $sftp_uri
expect "($sftp_uri) Password:"
send "$password\r"
expect "sftp>"
send "put out/work.DCM /sftp/output/$filename\r"
expect "sftp>"
send "bye\r"
EOD

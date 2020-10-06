API_KEY=$912e1ac3eb256a1923d6c2b88416df2aaf642b1f522bd042a2c676ca628d3aec
USER=$C:/users/karen/Documents/TAREA 1

curl -v --request POST --url 'https://www.virustotal.com/vtapi/v2/file/report' -d apikey=$API_KEY -d 'resource=$USER'

curl -X POST https://www.virustotal.com/vtapi/v2/file/scan -F apikey=912e1ac3eb256a1923d6c2b88416df2aaf642b1f522bd042a2c676ca628d3aec -F file=$USER

curl -X POST 'http://www.virustotal.com/vtapi/v2/url/report' -F apikey=$API_KEY -F resource=https://tines.io
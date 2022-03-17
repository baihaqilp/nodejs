curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode="HTML" -d text="<b>Project</b> : Hackathon BCA by HAI MP 06 <br>\
<b>Branch</b>: master <br>\
<b>Build </b> : OK <br>\
<b>Test suite</b> = Passed"
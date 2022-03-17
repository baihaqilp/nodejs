curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d parse_mode="HTML" -d text="<b>Project</b> : POC \
<b>Branch</b>: master \
<b>Build </b> : OK \
<b>Test suite</b> = Passed"
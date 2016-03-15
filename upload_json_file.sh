export AZURE_STORAGE_CONNECTION_STRING="DefaultEndpointsProtocol=https;AccountName=3dcytoflowdb;AccountKey=X2tMrUiIOMrFaFvQyMnA3jm8j3NIKk5VuOf00CpuFb5W65kEE+Xf42hikxggRHgmeRuyeTzf8F3QxpmWMMxU2g=="

VM_NAME=machine1
VM_PSW=machine1psw

VM_TOKEN=`curl "http://3dcytoflow.azurewebsites.net/File/GetToken?username=$VM_NAME&psw=$VM_PSW" | sed 's/\"//g'`

echo VMTOKEN=$VM_TOKEN

VM_REQUEST_ANALYSIS_JSON=`curl "http://3dcytoflow.azurewebsites.net/File/RequestAnalysis?vmId=$VM_TOKEN"`

echo $VM_REQUEST_ANALYSIS_JSON > json

#azure storage blob download lavieri-luis alarcon-vanessa/03-14-2016-04-35.fcs downloadedFcs

strindex() { 
  x="${1%%$2*}"
  [[ $x = $1 ]] && echo -1 || echo ${#x}
}


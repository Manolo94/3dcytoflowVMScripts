export AZURE_STORAGE_CONNECTION_STRING="DefaultEndpointsProtocol=https;AccountName=3dcytoflowdb;AccountKey=X2tMrUiIOMrFaFvQyMnA3jm8j3NIKk5VuOf00CpuFb5W65kEE+Xf42hikxggRHgmeRuyeTzf8F3QxpmWMMxU2g=="

VM_NAME=machine1
VM_PSW=machine1psw

VM_TOKEN=`curl "http://3dcytoflow.azurewebsites.net/File/GetToken?username=$VM_NAME&psw=$VM_PSW" | sed 's/\"//g'`

VM_REQUEST_ANALYSIS_JSON=`curl "http://3dcytoflow.azurewebsites.net/File/RequestAnalysis?vmId=$VM_TOKEN"`

FOUND=`echo $VM_REQUEST_ANALYSIS_JSON | jq ".Found"`

strindex() {
    x="${1%%$2*}"
    [[ $x = $1 ]] && echo -1 || echo ${#x}
}

if [ "$FOUND" == "true" ]
then 
    VM_FCS_LOCATION=`echo $VM_REQUEST_ANALYSIS_JSON | jq ".FileLocation"`

    echo ANALYSIS FOUND=$VM_FCS_LOCATION

    CONTAINER_INDEX=`strindex "$VM_FCS_LOCATION" "/"`

    CONTAINER_NAME=`echo $VM_FCS_LOCATION | cut -c2-$CONTAINER_INDEX`
    BLOB_NAME=`echo $VM_FCS_LOCATION | cut -c$[$CONTAINER_INDEX+2]-`

    BLOB_NAME=${BLOB_NAME%?}

    azure storage blob download -q $CONTAINER_NAME $BLOB_NAME downloadedFcs

    #remove the fcs extension
    EXTENSION_IDX=`strindex "$BLOB_NAME" ".fcs"`
    echo $BLOB_NAME | cut -c1-$EXTENSION_IDX > fcsPath
    echo $CONTAINER_NAME > containerName
else
    > fcsPath
    > containerName
    echo NO ANALYSIS FOUND
fi


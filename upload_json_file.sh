

export AZURE_STORAGE_CONNECTION_STRING="DefaultEndpointsProtocol=https;AccountName=3dcytoflowdb;AccountKey=X2tMrUiIOMrFaFvQyMnA3jm8j3NIKk5VuOf00CpuFb5W65kEE+Xf42hikxggRHgmeRuyeTzf8F3QxpmWMMxU2g=="

VM_NAME=Simulate
VM_PSW=AlmostThere

VM_TOKEN=`curl "http://3dcytoflow.azurewebsites.net/File/GetToken?username=$VM_NAME&psw=$VM_PSW" | sed 's/\"//g'`

echo VMTOKEN=$VM_TOKEN
path=`cat fcsPath`.json
container=`cat containerName`

path2=$container/$path
filePath=results/$path

echo ANALYSIS_FINISHED=`curl "http://3dcytoflow.azurewebsites.net/File/AnalysisFinished?vmId=$VM_TOKEN&location=$path2"`

azure storage blob upload -q $filePath $container $path 


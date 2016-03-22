#!/bin/bash
#Manuel
if [ "`cat analysisLock`" == "" ]
then
    echo lock > analysisLock

    ./scripts/request_download_fcs.sh
    
    if [ "`cat fcsPath`" != "" ]
    then
        fcsPath=`cat fcsPath`

        cd git/sd_pfromd/
        ./run_pfromd.sh -j1 -n5 ../../downloadedFcs/$fcsPath.fcs

        if [ "`cat resultPath`" != "" ]
        then
            mkdir -p ../../results/$fcsPath
            mv `cat resultPath`/points.txt ../../results/$fcsPath/
    
            cd ../..
            #Luis	    
            ./scripts/json-generator.sh results/$fcsPath/points.txt
    
            #Ryan
            ./scripts/upload_json_file.sh
        else
            echo Empty resultPath. Incomplete analysis
        fi
    else
        echo NO ANALYSIS TO BE PROCESSED
    fi

    > analysisLock
else
    echo This Machine is already processing an analysis

fi

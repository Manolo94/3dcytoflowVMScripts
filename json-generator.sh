#!/bin/bash
#declare arrays
x_array=()
y_array=()
z_array=()
#FileName
ResultFileName=results/`cat fcsPath`.json

#keep track of points
counter=0
#read file line by line and store all the x's in the x_array, 
#all the y's in the y_array and all the z's in the z_array
while IFS='' read -r line || [[ -n "$line" ]]; do
    c=0
    #split line by the comma
    for i in $(echo $line | tr " " "\n")
    do
       if   [ $c -eq 0 ] 
       then # x point
           x_array[counter]=$i
       elif [ $c -eq 1 ] 
       then # y point
           y_array[counter]=$i
       else # z point
           z_array[counter]=$i
       fi
       ((c++))
    done
    c=0
    ((counter++))
done < "$1"

#finish storing variables x, y, z points in their corresponding arrays

#for testing the first points of each earray
#echo "$counter points saved. x[0] = ${x_array[0]} y[0] = ${y_array[0]} z[0] = ${z_array[0]}"

#beginning of json
echo -e "{" >> $ResultFileName

END=$counter
for i in `seq 0 3`;
do
    if   [ $i -eq 0 ]
    then
        echo -e "\t\"x\":\n\t{" >> $ResultFileName
        
        j=0
        while [ $j -lt $END ] 
        do
            if [ $j -ne $((END-1)) ]
            then
                echo -e "\t\t\"$j\":${x_array[$j]}," >> $ResultFileName
            else
                echo -e "\t\t\"$j\":${x_array[$j]}" >> $ResultFileName
            fi
            ((j++))   
        done
        echo -e "\t}," >> $ResultFileName         
    elif [ $i -eq 1 ]
    then
        echo -e "\t\"y\":\n\t{" >> $ResultFileName

        j=0
        while [ $j -lt $END ]
        do
            if [ $j -ne $((END-1)) ]
            then
                echo -e "\t\t\"$j\":${y_array[$j]}," >> $ResultFileName
            else
                echo -e "\t\t\"$j\":${y_array[$j]}" >> $ResultFileName
            fi
            ((j++))
        done
        echo -e "\t}," >> $ResultFileName
    elif [ $i -eq 2 ]
    then
        echo -e "\t\"z\":\n\t{" >> $ResultFileName

        j=0
        while [ $j -lt $END ]
        do
            if [ $j -ne $((END-1)) ]
            then
                echo -e "\t\t\"$j\":${z_array[$j]}," >> $ResultFileName
            else
                echo -e "\t\t\"$j\":${z_array[$j]}" >> $ResultFileName
            fi
            ((j++))
        done
        echo -e "\t}," >> $ResultFileName
    else
        echo -e "\t\"cid\":\n\t{" >> $ResultFileName

        j=0
        while [ $j -lt $END ]
        do
            if [ $j -ne $((END-1)) ]
            then
                echo -e "\t\t\"$j\":1.0," >> $ResultFileName
            else
                echo -e "\t\t\"$j\":1.0" >> $ResultFileName
            fi
            ((j++))
        done
        echo -e "\t}" >> $ResultFileName
    fi    
done

echo -e "}" >> $ResultFileName

chown luislavieri:sudo $ResultFileName

chmod g+rw $ResultFileName

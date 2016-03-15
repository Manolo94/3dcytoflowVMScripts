for i in `seq 1 10`;
do
    a=$RANDOM
    b=$RANDOM
    c=$RANDOM
   
    echo -e "$a, $b, $c" >> points.txt
done

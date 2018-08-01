#!/bin/bash
PACOUNTER=$(cat ~/.PACOUNTER)
if [ -z $PACOUNTER ] || [ $PACOUNTER -ge $(pactl list sinks short | wc -l) ]
then
        PACOUNTER=1
else
        PACOUNTER=$(($PACOUNTER + 1))
fi
echo $PACOUNTER > ~/.PACOUNTER
letzteZeile=$(pactl list sinks short | tail -n $PACOUNTER | head -n 1)
array=($(echo $letzteZeile | tr " " "\n"))
sink=${array[0]}
pactl set-default-sink $sink
notify-send "Wechsle zu ${array[1]}" -t 800
INPUTS=`pactl list sink-inputs short | cut -f 1`
for i in $INPUTS; do
        pactl move-sink-input $i $sink
done

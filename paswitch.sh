#!/bin/bash
letzteZeile=$(pactl list sinks short | tail -n 1)
array=($(echo $letzteZeile | tr " " "\n"))
sink=${array[0]}
echo $sink
pactl set-default-sink $sink
INPUTS=`pactl list sink-inputs short | cut -f 1`
for i in $INPUTS; do
        pactl move-sink-input $i $sink
done

#!/bin/bash

objdump -d ./simple_foo > output.txt

declare -A instructions
declare -A functions

COUNT = 0
MATCHES = 0
INFUNCTION = false
while read line; do
    if [[ $INFUNCTION == true ]]; then
        if [[ -z $line ]]; then
            INFUNCTION=false
        else
            set $line
            reading=false
            for word in $line; do
                if [[ $reading == false ]] && [[ $word =~ ^[a-z][a-z][a-z][a-z]*$ ]] || [[ $word == "je" ]]; then
                    instructions[$word]=$((instructions[$word] + 1))
                    reading=true
                    COUNT=$((COUNT + 1))
                fi
            done
        fi
    elif [[ $line =~ ^[a-z0-9].*:$ ]]; then
        location="${line:0:16}"
        function="${line:18:-2}"

        functions[$function]=$location
       
        INFUNCTION=true

        MATCHES=$((MATCHES + 1))
    fi   
done < output.txt

printf "You have %d types of instructions:\n" "$COUNT"
for instruction in "${!instructions[@]}"; do
    printf "\t%-6s\t: Executed %3s times\n" "$instruction" "${instructions[$instruction]}"
done

printf "You have %d functions:\n" "$MATCHES"
for f in "${!functions[@]}"; do
    printf "\t%-21s\t: in address %s \n" "$f" "${functions[$f]}"
done

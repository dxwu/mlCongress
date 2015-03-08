#!/bin/bash

for file in *; do
    mv "$file" "$1_$file"; 
done

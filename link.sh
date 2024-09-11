#!/bin/bash

file_path=dotfiles
dfiles=$(ls -A ./$file_path)

for base_path in $dfiles
do
    full_path=$(realpath "$file_path/$base_path")
    ln -sf "$full_path" "$HOME/$base_path"
done

#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
	if ssh-keygen -c -C "user@fourandsix2" -P $line -f id_rsa; then
		echo $line
		break
	fi
done < "$1"


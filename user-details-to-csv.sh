#!/bin/bash

# Get your Graph access token from https://developer.microsoft.com/en-us/graph/graph-explorer
ACCESSTOKEN=$YOUR_ACCESS_TOKEN

INPUT="inputs.txt"
OUTPUT="graph-output_$(date +%Y-%m-%d_%H-%M-%S).csv"
DOMAIN="example.com"

echo 'First Name, Last Name, E-mail Address' > $OUTPUT

while read p;
do
	curl --silent \
		-H "Authorization: Bearer $ACCESSTOKEN" \
		"https://graph.microsoft.com/v1.0/users/$p@$DOMAIN" | jq [.givenName,.surname,.mail] | jq -r @csv
done < $INPUT

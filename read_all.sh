
mkdir -p stations

cat log/* \
	| sort -k2 -k1 \
	| awk 'OFS="\t" {v="stations/"$2".station"; print $0 > v}' 
	# print each record to a filename with the name of the station


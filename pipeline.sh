
function main {
	# the folder of the downloaded data
	DATA=./data/
	mkdir -p $DATA

	# log the station details
	LOG=./log/
	mkdir -p $LOG

    # to store the output SVG
    mkdir -p svg

	# store the current time
	now=`date | tr -s " " "_" `


	# fetch the TOBIKE data
	wget http://www.tobike.it/frmLeStazioni.aspx -O $DATA/tobike.aspx;

	# first parsing
	cat $DATA/tobike.aspx | tr -d '\000' \
	| grep -o "{RefreshMap(.*}" | sed 's/{RefreshMap(\(.*\))}/\1/' \
	| sed "s|','|\n|g" | sed "s|'||g" > $DATA/tobike.parsed
	echo "DONE: $DATA/tobike.parsed"


	# get the station
	cat $DATA/tobike.parsed \
	| head -n 9 | grep -v "<strong>" | sed 's/://g' | tr " " "_" \
	| iconv -c -f utf-8 -t ascii \
	| ruby -e 'puts readlines.map{|x| x.split "|" }.transpose.map{|x|x*" "}' \
	| tr -s " " "\t" | cut -f1,6,7  | head -n -8 \
	| ruby parse_status.rb | awk 'OFS="\t" {print $1,$3,$5,$5/($5+$6+$7+0.01)}' > $LOG/$now.stations
	echo "DONE: $LOG/$now.status"


	# $now.stations format:
	# DATETIME	NAME	ACTIVE	FRACTION_ACTIVE
}


# 3 days of work
end=$((SECONDS+259200));

while [ $SECONDS -lt $end ]; do
	main
	#sleep 1800 # sleeps for 30 minutes
	sleep 10
done

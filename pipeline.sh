DATA=./data/
mkdir -p $DATA

# fetch the TOBIKE data
wget http://www.tobike.it/frmLeStazioni.aspx -O $DATA/tobike.aspx;

cat $DATA/tobike.aspx | tr -d '\000' \
| grep -o "{RefreshMap(.*}" | sed 's/{RefreshMap(\(.*\))}/\1/' \
| sed "s|','|\n|g" | sed "s|'||g" > $DATA/tobike.parsed


cat $DATA/tobike.parsed \
| head -n 9 | grep -v "<strong>" | sed 's/://g' | tr " " "_" \
| iconv -c -f utf-8 -t ascii \
| ruby -e 'puts readlines.map{|x| x.split "|" }.transpose.map{|x|x*" "}' \
| tr -s " " "\t" | cut -f1,6,7  | head -n -8 > $DATA/tobike.stations






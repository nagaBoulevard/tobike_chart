DATA=./data/
mkdir -p $DATA

# fetch the TOBIKE data
wget http://www.tobike.it/frmLeStazioni.aspx -O $DATA/tobike_data.aspx;

# select the important data
cat $DATA/tobike_data.aspx | tr -d '\000' \
| grep -o "{RefreshMap(.*}" | sed 's/{RefreshMap(\(.*\))}/\1/' \
| sed "s|','|\n|g" | sed "s|'||g" > $DATA/tobike_data.parsed





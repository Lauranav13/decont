echo "Downloading samples..."

	url=$1
	sample=$(basename $1)

wget -P $2 $1

echo "Uncompressing samples..."

if [ "$3" = "yes" ]
then
	gunzip -k $2/$sample
fi 

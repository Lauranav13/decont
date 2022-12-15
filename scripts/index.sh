
	mkdir -p res/contaminants_idx
	echo "Running STAR index"
	STAR \
	--runThreadN 4 \
	--runMode genomeGenerate \
	--genomeDir $2 \
	--genomeFastaFiles $1 \
	--genomeSAindexNbases 9


        sid=$1

        mkdir -p out/trimmed
        mkdir -p log/cutadapt
        echo "Running cutadapt"
                cutadapt \
                -m 18 \
                -a TGGAATTCTCGGGTGCCAAGG \
                --discard-untrimmed \
                -o out/trimmed/${sid}.trimmed.fastq.gz \
                out/merged/${sid}.fastq.gz > log/cutadapt/${sid}.log

for fname in out/trimmed/*.fastq.gz
do
    	 	mkdir -p out/star/${sid}
		echo "Running STAR"
		STAR \
		--runThreadN 4 --genomeDir res/contaminants_idx \
		--outReadsUnmapped Fastx --readFilesIn out/trimmed/${sid}.trimmed.fastq.gz \
		--readFilesCommand gunzip -c \
		--outFileNamePrefix out/star/${sid}/
done 


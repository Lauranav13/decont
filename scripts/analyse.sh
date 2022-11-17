
if [ "$#" -eq 1 ]
then
        sample=$1

        mkdir -p out/trimmed
        mkdir -p log/cutadapt
        echo "Running cutadapt"
                cutadapt \
                -m 18 \
                -a TGGAATTCTCGGGTGCCAAGG \
                --discard-untrimmed \
                -o out/trimmed/${sample}.trimmed.fastq.gz \
                out/merged/${sample}.fastq.gz > log/cutadapt/${sample}.log

fi

for fname in out/trimmed/*.fastq.gz
do
    	 	mkdir -p out/star/${sample}
		echo "Running STAR"
		STAR \
		--runThreadN 4 --genomeDir res/contaminants_idx \
		--outReadsUnmapped Fastx --readFilesIn out/trimmed/${sample}.trimmed.fastq.gz \
		--readFilesCommand gunzip -c \
		--outFileNamePrefix out/star/${sample}/
done 


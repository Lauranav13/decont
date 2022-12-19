for url in $(cat data/urls)

do
	bash scripts/download.sh $url data/ yes
done

rm data/*.fastq

echo "Downloading contaminants"

bash scripts/download.sh https://bioinformatics.cnio.es/data/courses/decont/contaminants.fasta.gz res yes 
sed /'small nuclear'/d res/contaminants.fasta 

bash scripts/index.sh res/contaminants.fasta res/contaminants_idx

for sid in $(cat data/urls | cut -d"/" -f7 | cut -d"_" -f1,2 | cut -d"-" -f1 | sort | uniq)
do
	bash scripts/merge_fastqs.sh data out/merged $sid
	bash scripts/analyse.sh $sid
done

echo "Creating a log file with information on trimming and alignments results"
	touch  log/pipeline.log
 
for sid in $(cat data/urls | cut -d"/" -f7 | cut -d"_" -f1,2 | cut -d"-" -f1 | sort | uniq)
do
	echo "Sample: " $sid >> log/pipeline.log
	echo "------------------" >> log/pipeline.log

	echo "Cutadapt: " >> log/pipeline.log
	echo $(cat log/cutadapt/$sid.log | grep -e "Reads with adapters") >> log/pipeline.log
	echo $(cat log/cutadapt/$sid.log | grep -e "Total basepairs") >> log/pipeline.log
	echo -e "\n" >> log/pipeline.log

	echo "STAR: " >> log/pipeline.log
	echo $(cat out/star/$sid/Log.final.out | grep -e "Uniquely mapped reads %") >> log/pipeline.log
	echo $(cat out/star/$sid/Log.final.out | grep -e "% of reads mapped to multiple loci") >> log/pipeline.log
	echo $(cat out/star/$sid/Log.final.out | grep -e "% of reads mapped to too many loci") >> log/pipeline.log
	
	echo -e "\n" >>log/pipeline.log
done

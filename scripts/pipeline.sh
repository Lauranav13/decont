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


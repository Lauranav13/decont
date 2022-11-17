for url in $(cat data/urls)

do
	bash scripts/download.sh $url data/ yes
done

bash scripts/download.sh https://bioinformatics.cnio.es/data/courses/decont/contaminants.fasta.gz res yes 

bash scripts/index.sh res/contaminants.fasta res/contaminants_idx

for sid in $(cat data/urls | cut -d"/" -f7 | cut -d"_" -f1,2 | cut -d"-" -f1 | sort | uniq)
do
    bash scripts/merge_fastqs.sh data out/merged $sid
done

for sample in $(cat data/urls | cut -d"/" -f7 | cut -d"_" -f1,2 | cut -d"-" -f1 | sort | uniq)
do
    bash scripts/analyse.sh $sample
done


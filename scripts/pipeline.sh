for url in $(cat data/urls)

do
	bash scripts/download.sh $url data/ yes
done

bash scripts/download.sh https://bioinformatics.cnio.es/data/courses/decont/contaminants.fasta.gz res yes 

bash scripts/index.sh res/contaminants.fasta res/contaminants_idx


for url in $(cat data/urls)

do
	bash scripts/download.sh $url data/ yes
done


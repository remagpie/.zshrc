function zhooks {
	for name in "precmd" "preexec"; do
		echo $name ":"
		local var_name="${name}_functions"
		for f in ${(P)var_name}; do
			echo "\t"$f
		done;
	done
}

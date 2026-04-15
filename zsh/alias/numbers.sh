#generate numbers
gen() {
    n=$1
    for ((i=0; i<$2; i++)); do
        echo $n
        ((n*=2))
    done
}
#generate numbers and convert units
genu() {
  n=$1
  for ((i=0; i<$2; i++)); do
    if [[ $n -gt 60000 ]]; then
      printf "%.2fm\n" "$((n / 1000.0 / 60.0))"
    elif [[ $n -gt 1000 ]]; then
      printf "%.2fs\n" "$((n / 1000.0))"
    else
      echo "$n ms"
    fi
    ((n *= 2))
  done
}

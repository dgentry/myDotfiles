for x in {0..8}; do
    for i in {30..37}; do
        for a in {40..47}; do
            echo -ne "\033[$x;$i;$a""m\\\033[$x;$i;$a""m\033[0;37;40m "
        done
        echo
    done
done
echo ""

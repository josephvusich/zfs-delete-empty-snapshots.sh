



```sh
zfs create export/test
mkfile 10m /export/test/bla
zfs snapshot export/test@snapshot1
zfs snapshot export/test@snapshot2
rm /export/test/bla
```

Now both snapshots should contain (the same) 10MB of valuable data (the
file /export/test/bla just removed). But:


`zfs list -r export/test`

```
NAME                   USED    AVAIL  REFER  MOUNTPOINT
export/test            24.5K   171G  24.5K  /export/test
export/test@snapshot1  0       -     24.5K  -
export/test@snapshot2  0       -     24.5K  -
```

... indicates two empty snapshots. But after removing one of the
snapshots ...

`zfs destroy export/test@snapshot1`

... the data magically shows up on the second snapshot (in my case not
10MB, because the compression setting was inherited from the parent zfs)

`zfs list -r export/test`

```
NAME                   USED  AVAIL  REFER  MOUNTPOINT
export/test            47K   171G  24.5K  /export/test
export/test@snapshot2  22.5K    -  24.5K  -
```

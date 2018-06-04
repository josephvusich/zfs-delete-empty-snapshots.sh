[![Build Status](https://travis-ci.org/Josef-Friedrich/zfs-delete-emtpy-snapshots.sh.svg?branch=master)](https://travis-ci.org/Josef-Friedrich/zfs-delete-emtpy-snapshots.sh)

# zfs-delete-emtpy-snapshots.sh


## Summary / Short description

> This is the management script of the skeleton.sh project!

## Usage

```
skeleton.sh v1.0

Usage: skeleton.sh [-AdhrSstv]

This is the management script of the skeleton.sh project!

Options:
	-A, --sync-all
	  Sync all projects that have the same parent folder as this
	  project.
	-d, --sync-dependencies
	  Sync external dependenices (e. g. test-helper.sh bats)
	-h, --help
	  Show this help message
	-r, --render-readme
	  Render “README.md”.
	-S, -sync-skeleton
	  Sync your project with the skeleton project and update some
	  boilerplate files (e. g. Makefile test/lib/skeleton.sh)
	-s, --short-description
	  Show a short description / summary
	-t, --test
	  Run the tests located in the “test” folder.
	-v, --version
	  Show the version number of this script.

```

## Testing

```
make test
```





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

#!/usr/bin/env bats

setup() {
	. ./test/lib/test-helper.sh
	mock_path test/bin
}

@test "run ./zfs-delete-empty-snapshots.sh data/backup" {
	run ./zfs-delete-empty-snapshots.sh data/backup
	[ "$status" -eq 0 ]
	[ "${lines[0]}" = "Destroying empty snapshot “data/backup@zfs-auto-snap_daily-2018-04-30-2134”! (USED=0)" ]
	[ "${lines[1]}" = "Destroying empty snapshot “data/backup/host/fractal@zfs-auto-snap_hourly-2018-06-06-1605”! (USED=0)" ]
}

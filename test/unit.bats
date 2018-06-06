#!/usr/bin/env bats

setup() {
	. ./test/lib/test-helper.sh
	mock_path test/bin
	source_exec zfs-delete-empty-snapshots.sh
}

@test "run _get_datasets" {
	run _get_datasets data/backup
	[ "$status" -eq 0 ]
	[ "${lines[0]}" = "data/backup" ]
	[ "${lines[1]}" = "data/backup/host/fractal" ]
}

@test "run _get_empty_snapshots" {
	run _get_empty_snapshots data/backup
	[ "$status" -eq 0 ]
	[ "${lines[0]}" = "data/backup@zfs-auto-snap_daily-2018-04-30-2134" ]
	[ "${lines[1]}" = "data/backup@zfs-auto-snap_weekly-2018-04-30-2134" ]
}

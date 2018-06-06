#!/usr/bin/env bats

setup() {
	. ./test/lib/test-helper.sh
	mock_path test/bin
	source_exec zfs-delete-empty-snapshots.sh
}

@test "run _get_datasets" {
	run _get_datasets
	[ "$status" -eq 0 ]
	[ "${lines[0]}" = "data/backup" ]
	[ "${lines[1]}" = "data/backup/host/fractal" ]
}

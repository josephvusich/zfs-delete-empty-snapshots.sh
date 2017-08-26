#!/usr/bin/env bats

setup() {
	. ./test/lib/test-helper.sh
	#mock_path test/bin
	source_exec zfs-delete-empty-snapshots.sh
}

@test "run ./zfs-delete-empty-snapshots.sh" {
	run ./zfs-delete-empty-snapshots.sh
	[ "$status" -eq 1 ]
	[ "${lines[0]}" = "Usage: zfs-delete-empty-snapshots.sh <dataset>" ]
}

#!/usr/bin/env bats
# required: https://github.com/bats-core/bats-core

load ../common.sh

@test "increase_patch_version" {
  run increase_patch_version 0
  [ "$output" = "0.0.1" ]

  run increase_patch_version 0.1
  [ "$output" = "0.1.1" ]

  run increase_patch_version 0.1.0
  [ "$output" = "0.1.1" ]

  run increase_patch_version 0.0.x
  [ "$output" = "0.0.x" ]
}

@test "increase_minor_version" {
  run increase_minor_version 0
  [ "$output" = "0.1.0" ]

  run increase_minor_version 0.1.1
  [ "$output" = "0.2.0" ]

  run increase_minor_version 0.1
  [ "$output" = "0.2.0" ]

  run increase_minor_version 0.x
  [ "$output" = "0.x.0" ]
}

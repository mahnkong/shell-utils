#!/usr/bin/env bats
#
# vim: syntax=sh
#
. ../lib/collections.shm

@test "parameter check set_put" {
    run collections_set_put 
    [ "$status" != "0" ]
    run collections_set_put 1
    [ "$status" != "0" ]
}

@test "parameter check set_contains" {
    run collections_set_contains
    [ "$status" != "0" ]
    run collections_set_contains 1
    [ "$status" != "0" ]
}

@test "parameter check set_delete" {
    run collections_set_delete
    [ "$status" != "0" ]
    run collections_set_delete 1
    [ "$status" != "0" ]
}

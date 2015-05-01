#!/usr/bin/env bats
#
# vim: syntax=sh
#

@test "parameter check set_put" {
    . ../lib/collections.shm
    run collections_set_put 
    [ "$status" != "0" ]
    run collections_set_put 1
    [ "$status" != "0" ]
}

@test "parameter check set_contains" {
    . ../lib/collections.shm
    run collections_set_contains
    [ "$status" != "0" ]
    run collections_set_contains 1
    [ "$status" != "0" ]
}

@test "parameter check set_delete" {
    . ../lib/collections.shm
    run collections_set_delete
    [ "$status" != "0" ]
    run collections_set_delete 1
    [ "$status" != "0" ]
}

@test "parameter check set_items" {
    . ../lib/collections.shm
    run collections_set_items
    [ "$status" != "0" ]
}

@test "test set" {
    . ../lib/collections.shm
    run collections_set_contains "test" "My set item"
    [ "$status" != "0" ]
    run collections_set_push "test" "My set item"
    run collections_set_contains "test" "My set item"
    [ "$status" == "0" ]
    run collections_set_push "test" "My new set item"
    run collections_set_items "test"  
    [ "$output" == "My set item\nMy new set item\n"]
    run collections_set_delete "test" "My set item"
    run collections_set_items "test"  
    [ "$output" == "My new set item\n"]
    run collections_set_contains "test" "My set item"
    [ "$status" != "0" ]
    run collections_set_contains "test" "My new set item"
    [ "$status" == "0" ]
}

## map

@test "parameter check map_put" {
    . ../lib/collections.shm
    run collections_map_put 
    [ "$status" != "0" ]
    run collections_map_put 1
    [ "$status" != "0" ]
    run collections_map_put 1 1
    [ "$status" != "0" ]
}

@test "parameter check map_contains" {
    . ../lib/collections.shm
    run collections_map_contains
    [ "$status" != "0" ]
    run collections_map_contains 1
    [ "$status" != "0" ]
}

@test "parameter check map_delete" {
    . ../lib/collections.shm
    run collections_map_delete
    [ "$status" != "0" ]
    run collections_map_delete 1
    [ "$status" != "0" ]
}

@test "parameter check map_get" {
    . ../lib/collections.shm
    run collections_map_get
    [ "$status" != "0" ]
    run collections_map_get 1
    [ "$status" != "0" ]
}

@test "test map" {
    . ../lib/collections.shm
    run collections_map_contains "test" "mykey"
    [ "$status" != "0" ]
    run collections_map_push "test" "mykey" "My value"
    run collections_map_contains "test" "mykey"
    [ "$status" == "0" ]
    run collections_map_get "test" "mykey"
    [ "$status" == "0" ]
    [ "$output" == "My value\n"]
    run collections_map_push "test" "mykey" "My new value"
    run collections_map_get "test" "mykey"
    [ "$status" == "0" ]
    [ "$output" == "My new value\n"]
    run collections_set_delete "test" "mykey"
    run collections_set_contains "test" "mykey"
    [ "$status" != "0" ]
}

#!/usr/bin/env bats
#
# vim: syntax=sh
#
function setup {
    . $BATS_TEST_DIRNAME/../lib/collections.shm
}

MAP_NAME="testmap"
SET_NAME="testset"

@test "parameter check set_put" {
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

@test "parameter check set_items" {
    run collections_set_items
    [ "$status" != "0" ]
}

@test "set_contains_fails_if_item_not_inside" {
    run collections_set_contains $SET_NAME "My set item"
    [ "$status" != "0" ]
}

@test "set_contains_succeeds_if_item_inside" {
    run collections_set_push $SET_NAME "My set item"
    run collections_set_contains $SET_NAME "My set item"
    [ "$status" == "0" ]
}

@test "set_items_returns_all_items_inside" {
    run collections_set_items $SET_NAME
    [ "$output" == ""]
    run collections_set_push $SET_NAME "My set item 1"
    run collections_set_push $SET_NAME "My set item 2"
    run collections_set_items $SET_NAME  
    [ "$output" == "My set item 1\nMy set item 2\n"]
}

@test "set_delete_works" {
    run collections_set_push $SET_NAME "My set item"
    run collections_set_contains $SET_NAME "My set item"
    [ "$status" == "0" ]
    run collections_set_delete $SET_NAME "My set item"
    run collections_set_contains $SET_NAME "My set item"
    [ "$status" != "0" ]
}

@test "parameter check map_put" {
    run collections_map_put 
    [ "$status" != "0" ]
    run collections_map_put 1
    [ "$status" != "0" ]
    run collections_map_put 1 1
    [ "$status" != "0" ]
}

@test "parameter check map_contains" {
    run collections_map_contains
    [ "$status" != "0" ]
    run collections_map_contains 1
    [ "$status" != "0" ]
}

@test "parameter check map_delete" {
    run collections_map_delete
    [ "$status" != "0" ]
    run collections_map_delete 1
    [ "$status" != "0" ]
}

@test "parameter check map_get" {
    run collections_map_get
    [ "$status" != "0" ]
    run collections_map_get 1
    [ "$status" != "0" ]
}

@test "parameter check map_keys" {
    run collections_map_keys
    [ "$status" != "0" ]
}

@test "map_contains_fails_if_key_not_exist" {
    run collections_map_contains $MAP_NAME "mykey"
    [ "$status" != "0" ]
}

@test "map_contains_succeeds_if_key_exist" {
    run collections_map_push $MAP_NAME "mykey" "My value"
    run collections_map_contains $MAP_NAME "mykey"
    [ "$status" == "0" ]
}

@test "map_get_returns_value_for_key" {
    run collections_map_push $MAP_NAME "mykey" "My value"
    run collections_map_get $MAP_NAME "mykey"
    [ "$status" == "0" ]
    [ "$output" == "My value\n"]
}

@test "map_get_returns_nothing_if_key_not_exists" {
    run collections_map_get $MAP_NAME "mykey"
    [ "$status" != "0" ]
    [ "$output" == ""]
}

@test "map_overwrite_value_for_existing_key" {
    run collections_map_push $MAP_NAME "mykey" "My value"
    run collections_map_get $MAP_NAME "mykey"
    [ "$output" == "My value\n"]
    run collections_map_push $MAP_NAME "mykey" "My new value"
    run collections_map_get $MAP_NAME "mykey"
    [ "$output" == "My new value\n"]
}

@test "map_keys_returns_all_keys_in_map" {
    run collections_map_keys $MAP_NAME | sort
    [ "$output" == ""]
    run collections_map_push $MAP_NAME "mykey1" "value"
    run collections_map_push $MAP_NAME "mykey2" "value"
    run collections_map_keys $MAP_NAME | sort
    [ "$output" == "mykey1\nmykey2"]
}

@test "map_delete_works" {
    run collections_map_push $MAP_NAME "mykey1" "value"
    run collections_map_contains $MAP_NAME "mykey"
    [ "$status" == "0" ]
    run collections_map_delete $MAP_NAME "mykey"
    run collections_map_contains $MAP_NAME "mykey"
    [ "$status" != "0" ]
}


#!/bin/bash

DIRNAME=$(dirname $0)
ASSERT_LIB=$DIRNAME/../3rdparty/assert.sh

prepare_test_env() {
    local assert_lib_url=http://raw.github.com/lehmannro/assert.sh/v1.1/assert.sh
    if [ ! -f $ASSERT_LIB ]; then
        mkdir -p $(dirname $ASSERT_LIB)
        echo "Assert lib not found - downloading..."
        wget -qO $ASSERT_LIB $assert_lib_url
        if [ "$?" != "0" ];then
            echo "Download failed, please grab it manually and put it to $ASSERT_LIB and rerun the test"
            exit 1
        fi
    fi
}

prepare_test_env
. $ASSERT_LIB
. $DIRNAME/../lib/collections.shm

assert_raises "collections_set_put" 1
assert_raises "collections_set_put 1" 1
assert_end parameter_collections_set_put

assert_raises "collections_set_contains" 1
assert_raises "collections_set_contains 1" 1
assert_end parameter_collections_set_contains

assert_raises "collections_set_delete" 1
assert_raises "collections_set_delete 1" 1
assert_end parameter_collections_set_delete

assert_raises "collections_set_items" 1
assert_end parameter_collections_set_items

assert_raises "collections_set_size" 1
assert_end parameter_collections_set_size

assert_raises "collections_set_clear" 1
assert_end parameter_collections_set_clear

assert_raises "collections_map_put" 1
assert_raises "collections_map_put 1" 1
assert_raises "collections_map_put 1 1" 1
assert_end parameter_collections_map_put

assert_raises "collections_map_contains" 1
assert_raises "collections_map_contains 1" 1
assert_end parameter_collections_map_contains

assert_raises "collections_map_delete" 1
assert_raises "collections_map_delete 1" 1
assert_end parameter_collections_map_delete

assert_raises "collections_map_get" 1
assert_raises "collections_map_get 1" 1
assert_end parameter_collections_map_get

assert_raises "collections_map_keys" 1
assert_end parameter_collections_map_keys

assert_raises "collections_map_size" 1
assert_end parameter_collections_map_size

assert_raises "collections_map_clear" 1
assert_end parameter_collections_map_clear

assert_raises "collections_list_push" 1
assert_raises "collections_list_push 1" 1
assert_end parameter_collections_list_push

assert_raises "collections_list_unshift" 1
assert_raises "collections_list_unshift 1" 1
assert_end parameter_collections_list_unshift

assert_raises "collections_list_shift" 1
assert_end parameter_collections_list_shift

assert_raises "collections_list_pop" 1
assert_end parameter_collections_list_pop

assert_raises "collections_list_get" 1
assert_raises "collections_list_get 1" 1
assert_raises "collections_list_get 1 test" 1
assert_end parameter_collections_list_get

assert_raises "collections_list_delete" 1
assert_raises "collections_list_delete 1" 1
assert_raises "collections_list_delete 1 test" 1
assert_end parameter_collections_list_delete

assert_raises "collections_list_all" 1
assert_end parameter_collections_list_all

assert_raises "collections_list_insert" 1
assert_raises "collections_list_insert 1" 1
assert_raises "collections_list_insert 1 1" 1
assert_raises "collections_list_insert 1 test 1" 1
assert_end parameter_collections_list_insert

assert_raises "collections_list_size" 1
assert_end parameter_collections_list_size

assert_raises "collections_list_clear" 1
assert_end parameter_collections_list_clear

testcase=list_push_adds_element_at_end_of_list
collections_list_push $testcase "entry 1"
collections_list_push $testcase "entry 2"
size=$(collections_list_size $testcase)
last_index=$(( $size - 1))
assert "collections_list_get $testcase $last_index" "entry 2\n"
assert_end $testcase

testcase=list_unshift_adds_element_at_beginning_of_list
collections_list_push $testcase "entry 1"
assert "collections_list_all $testcase" "entry 1\n"
collections_list_unshift $testcase "entry 2"
assert "collections_list_all $testcase" "entry 2\nentry 1\n"
assert_end $testcase

testcase=list_pop_gets_last_element_and_removes_it
collections_list_push $testcase "entry 1"
collections_list_push $testcase "entry 2"
assert "collections_list_all $testcase" "entry 1\nentry 2\n"
assert "collections_list_pop $testcase" "entry 2\n"
assert "collections_list_all $testcase" "entry 1\n"
assert_end $testcase

testcase=list_shift_gets_first_element_and_removes_it
collections_list_push $testcase "entry 1"
collections_list_push $testcase "entry 2"
assert "collections_list_all $testcase" "entry 1\nentry 2\n"
assert "collections_list_shift $testcase" "entry 1\n"
assert "collections_list_all $testcase" "entry 2\n"
assert_end $testcase

testcase=list_all_returns_complete_list
assert "collections_list_all $testcase" ""
collections_list_push $testcase "entry 1"
collections_list_push $testcase "entry 2"
assert "collections_list_all $testcase" "entry 1\nentry 2\n"
assert_end $testcase

testcase=list_delete_works
collections_list_push $testcase "entry 1"
collections_list_push $testcase "entry 2"
collections_list_push $testcase "entry 3"
assert "collections_list_all $testcase" "entry 1\nentry 2\nentry 3\n"
collections_list_delete $testcase 1
assert "collections_list_all $testcase" "entry 1\nentry 3\n"
collections_list_delete $testcase 0
assert "collections_list_all $testcase" "entry 3\n"
assert_end $testcase

testcase=list_delete_fails_if_index_to_big
collections_list_push $testcase "entry 1"
collections_list_push $testcase "entry 2"
collections_list_push $testcase "entry 3"
assert_raises "collections_list_delete $testcase 100" 1
assert "collections_list_all $testcase" "entry 1\nentry 2\nentry 3\n"
assert_end $testcase

testcase=list_insert_works
collections_list_push $testcase "entry 1"
collections_list_push $testcase "entry 2"
collections_list_push $testcase "entry 3"
assert "collections_list_all $testcase" "entry 1\nentry 2\nentry 3\n"
collections_list_insert $testcase 1 "entry 4"
assert "collections_list_all $testcase" "entry 1\nentry 4\nentry 3\n"
collections_list_insert $testcase 0 "entry 5"
assert "collections_list_all $testcase" "entry 5\nentry 4\nentry 3\n"
assert_end $testcase

testcase=list_insert_fails_if_index_to_big
collections_list_push $testcase "entry 1"
collections_list_push $testcase "entry 2"
collections_list_push $testcase "entry 3"
assert_raises "collections_list_insert $testcase 100 'entry 4'" 1
assert "collections_list_all $testcase" "entry 1\nentry 2\nentry 3\n"
assert_end $testcase

testcase=list_get_works
collections_list_push $testcase "entry 1"
collections_list_push $testcase "entry 2"
collections_list_push $testcase "entry 3"
assert "collections_list_get $testcase 0" "entry 1\n"
assert "collections_list_get $testcase 1" "entry 2\n"
assert "collections_list_get $testcase 2" "entry 3\n"
assert "collections_list_get $testcase 100" ""
assert_end $testcase


testcase=list_size_returns_list_size
assert "collections_list_size $testcase" "0"
collections_list_push $testcase "entry"
collections_list_push $testcase "entry"
assert "collections_list_size $testcase" "2"
assert_end $testcase

testcase=list_clear_works
collections_list_push $testcase "entry"
collections_list_push $testcase "entry"
assert "collections_list_size $testcase" "2"
collections_list_clear $testcase
assert "collections_list_size $testcase" "0"
assert_end $testcase

testcase=set_contains_fails_if_item_not_inside
assert_raises "collections_set_contains $testcase 'My set item'" 1
assert_end $testcase

testcase=set_contains_succeeds_if_item_inside
collections_set_put $testcase "My set item"
assert_raises "collections_set_contains $testcase 'My set item'" 0
assert_end $testcase

testcase=set_items_returns_all_items_inside
assert "collections_set_items $testcase" ""
collections_set_put $testcase "My set item 1"
collections_set_put $testcase "My set item 2"
assert "collections_set_items $testcase" "My set item 1\nMy set item 2\n"
assert_end $testcase

testcase=set_delete_works
collections_set_put $testcase "My set item"
assert_raises "collections_set_contains $testcase 'My set item'" 0
collections_set_delete $testcase "My set item"
assert_raises "collections_set_contains $testcase 'My set item'" 1
assert_end $testcase

testcase=set_size_returns_set_size
assert "collections_set_size $testcase" "0"
collections_set_put $testcase "My set item 1"
collections_set_put $testcase "My set item 2"
assert "collections_set_size $testcase" "2"
assert_end $testcase

testcase=set_clear_works
collections_set_put $testcase "item1"
collections_set_put $testcase "item2"
assert "collections_set_size $testcase" "2"
collections_set_clear $testcase
assert "collections_set_size $testcase" "0"
assert_end $testcase

testcase=map_contains_fails_if_key_not_exist
assert_raises "collections_map_contains $testcase 'key1'" 1
assert_end $testcase

testcase=map_contains_succeeds_if_key_exist
collections_map_put $testcase "key1" "value1"
assert_raises "collections_map_contains $testcase 'key1'" 0
assert_end $testcase

testcase=map_get_returns_value_for_key
collections_map_put $testcase "key1" "value1"
assert_raises "collections_map_get $testcase 'key1'" 0
assert "collections_map_get $testcase 'key1'" "value1"
assert_end $testcase

testcase=map_get_returns_nothing_if_key_not_exists
assert_raises "collections_map_get $testcase 'key1'" 1
assert "collections_map_get $testcase 'key1'" ""
assert_end $testcase

testcase=map_overwrite_value_for_existing_key
collections_map_put $testcase "key1" "value1"
assert "collections_map_get $testcase 'key1'" "value1"
collections_map_put $testcase "key1" "value2"
assert "collections_map_get $testcase 'key1'" "value2"
assert_end $testcase

testcase=map_keys_returns_all_keys_in_map
assert "collections_map_keys $testcase" ""
collections_map_put $testcase "key1" "value1"
collections_map_put $testcase "key2" "value2"
assert "collections_map_keys $testcase" "key1\nkey2\n"
assert_end $testcase

testcase=map_delete_works
collections_map_put $testcase "key1" "value1"
assert_raises "collections_map_contains $testcase 'key1'" 0
collections_map_delete $testcase "key1"
assert_raises "collections_map_contains $testcase 'key1'" 1
assert_end $testcase

testcase=map_size_returns_map_size
assert "collections_map_size $testcase" "0"
collections_map_put $testcase "key1" "value1"
collections_map_put $testcase "key2" "value2"
assert "collections_map_size $testcase" "2"
assert_end $testcase

testcase=map_clear_works
collections_map_put $testcase "key1" "value1"
collections_map_put $testcase "key2" "value2"
assert "collections_map_size $testcase" "2"
collections_map_clear $testcase
assert "collections_map_size $testcase" "0"
assert_end $testcase


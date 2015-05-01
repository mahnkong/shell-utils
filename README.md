# shell-utils
Utilities and helper methods for shell programming (bash)

This project contains: 

## collections.shm

a module providing basic collections functionality (Set and Map) for **small** collections.
  
Sometimes when creating shell scripts, it would be nice to have basic collections such as a Set or a Map.
Therefore I created a shell module providing a Set and Map implementation based on flat files. The files storing the collection data are automatically deleted when exiting the script.

* Map Example usage:
  ```bash
  #load the module
  . shell-utils/lib/collections.shm
  
  # populate the map with some data
  for i in $(seq 1 10); do
    collections_map_put mymap "key${i}" "value ${i}"
  done

  # iterate over the keys
  for key in $(collections_map_keys mymap); do
    # get the value for key
    echo "key: ${key}, value: "$(collections_map_get mymap $key)
  done
  ```

* Map functions (parameters):
  * collections_map_contains (identifier, key):
    
    checks whether the *key* exists in the map identified by *identifier*, returns true if the key exists
    
  * collections_map_delete (identifier, key):
  
    deletes the *key* and it's value from the map identified by *identifier*
    
  * collections_map_get (identifier, key):
  
    echoes the value for *key* from the map identified by *identifier*

  * collections_map_keys (identifier):
  
    echoes all the keys from the map identified by *identifier*
  
  * collections_map_put (identifier, key, value):
  
    stores the given *key* / *value* pair in the map identified by *identifier*
  
  * collections_map_size (identifier):
  
    echoes the number of *key* / *value* pairs of the map identified by *identifier*
* Set Example usage:
  ```bash
  #load the module
  . shell-utils/lib/collections.shm
  
  # populate the set with some data
  for i in $(seq 1 10); do
      collections_set_put myset "item $i"
  done
  
  # check if specific items exist:
  collections_set_contains myset "item 1" && echo "item 1 exists" # echoes "item 1 exists"
  collections_set_contains myset "item 11" && echo "item 11 exists" # echoes nothing
  
  # delete item
  collections_set_delete myset "item 1"
  collections_set_contains myset "item 1" && echo "item 1 exists" # echoes nothing
  ```
    
* Set functions (parameters):
  * collections_set_contains (identifier, item)
  
    checks whether the *item* is inside the set identified by *identifier*, returns true if the item exists
  
  * collections_set_delete (identifier, item)
  
    removes the *item* from the set identified by *identifier*
  
  * collections_set_items (identifier)
  
    echoes all the items of the set identified by *identifier*
  
  * collections_set_put (identifier, item)
  
    puts the *item* into the set identified by *identifier*
  
  * collections_set_size (identifier)
  
    echoes the number of items inside the set identified by *identifier*

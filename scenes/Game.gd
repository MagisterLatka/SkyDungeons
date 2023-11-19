extends Node

var numOfKeys = 0

func get_keys():
	return numOfKeys
	
func add_key():
	numOfKeys += 1
	
func reduce_key():
	numOfKeys -= 1

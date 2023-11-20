extends Node

var numOfKeys = 0
const MAXHEALTH = 10
var health = MAXHEALTH
var level = 0
	
func get_health():
	return health

func get_keys():
	return numOfKeys
	
func add_key():
	numOfKeys += 1
	
func reduce_key():
	numOfKeys -= 1

func change_level():
	if level == 0:
		get_tree().change_scene_to_file("res://scenes/Level1.tscn")
	level += 1

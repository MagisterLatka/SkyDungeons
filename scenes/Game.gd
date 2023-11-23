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
	
func game_over():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
	

func win_game():
	get_tree().change_scene_to_file("res://scenes/outro.tscn")

func new_game():
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
	health = MAXHEALTH
	numOfKeys = 0
	level = 0

func change_level():
	if level == 0:
		get_tree().change_scene_to_file("res://scenes/Level1.tscn")
		level = 1
	elif level == 1:
		get_tree().change_scene_to_file("res://scenes/LevelFinal.tscn")
		level == 2
	

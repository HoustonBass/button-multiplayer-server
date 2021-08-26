extends Node

var userName : String = '' setget set_name
var count : int = 0 setget set_count, get_count

func set_name(userName):
	userName = userName

func set_count(count):
	count = count
func get_count():
	return count

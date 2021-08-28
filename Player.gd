extends Node

var id : int setget set_id,  get_id
var user_name : String = '' setget set_user_name, get_user_name
var count : int = 0 setget set_count, get_count

func set_id(player_id: int) -> void:
	id = player_id

func get_id() -> int:
	return id

func set_user_name(new_name : String) -> void:
	user_name = new_name

func get_user_name() -> String:
	return user_name

func set_count(newCount : int) -> void:
	count = newCount
	
func get_count() -> int:
	return count

func add_to_player_count() -> void:
	count += 1

func update_player_data(player_data : Dictionary):
	if player_data["count"] != null:
		count = count;

func get_player_data() -> Dictionary:
	return {
		"id": id,
		"count": count,
		"user_name": user_name,
	}

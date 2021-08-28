extends Node

var playerTemplate = load("res://Player.tscn")

func create_new_player(player_id, user_name):
	var player = playerTemplate.instance()
	player.set_id(player_id)
	player.set_user_name(user_name)
	player.set_count(0)
	player.set_name(str(player_id))
	return player

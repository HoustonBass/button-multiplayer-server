extends Node

const port = 5000
const max_players = 5

var network = NetworkedMultiplayerENet.new()

var playerTemplate = load("res://Player.tscn")

func _ready():
	StartServer()

func StartServer():
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	print('server started')
	
	network.connect("peer_connected",    self, "_client_connected"   )
	network.connect("peer_disconnected", self, "_client_disconnected")

func _client_connected(player_id : int):
	print("New client connected: " + str(player_id))

func _client_disconnected(player_id: int):
	var player =  $Players.get_node(str(player_id))
	if player != null:
		print("Player %d disconnected, removing a player named %s" % [player_id, player.get_user_name()])
		DeletePlayer(player_id)
		player.queue_free()
	else:
		print("Player %d never created a player, whatever" % [player_id])
	
remote func add_new_player(user_name):
	var player_id : int = get_tree().get_rpc_sender_id() 
	print("Adding new played name %s with id %d" % [user_name, player_id])
	var new_player = Players.create_new_player(player_id, user_name)
	$Players.add_child(new_player)
	for player in $Players.get_children():
		rpc_id(player_id, "add_player", player.get_player_data())
		if player.get_id() != player_id:
			rpc_id(player.get_id(), "add_player", new_player.get_player_data())

remote func update_player_data(player_data):
	var player_id = str(get_tree().get_rpc_sender_id())
	var player = $Players.get_node(player_id)
	player.update_data(player_data)
	SyncConnectedPlayers(player_id, player_data)

func DeletePlayer(player_id):
	for player in $Players.get_children():
		if player.get_id() != player_id:
			rpc_id(player.get_id(), "delete_player", player_id)

func SyncConnectedPlayers(updated_player: int, update_player_data: Dictionary):
	for player in $Players.get_children():
		if updated_player != player.get_id():
			rpc_id(player.get_id(), "update_player", update_player_data)

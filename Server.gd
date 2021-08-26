extends Node

const port = 5000
const max_players = 5

var network = NetworkedMultiplayerENet.new()

func _ready():
	StartServer()

func StartServer():
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	print('server started')
	
	
	network.connect("peer_connected",    self, "_client_connected"   )
	network.connect("peer_disconnected", self, "_client_disconnected")

func _client_connected(player_id):
	print('a client connected ' + str(player_id))
	
func _client_disconnected(player_id):
	print('a client disconnected ' + str(player_id))

	var newPlayer = load("res://Player.tscn").instance()
	newPlayer.set_name(str(player_id))     # spawn players with their respective names
	get_tree().get_root().add_child(newPlayer)

extends Node2D

class_name Lobby

var default_port = 32400

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
@export var lobby_player_scene: PackedScene

func _ready() -> void:
	add_player(PlayerData)
	#multiplayer.peer_connected.connect(peer_connected)
	
	multiplayer.connected_to_server.connect(connected_to_server)
	
#func peer_connected(id):
	#print("_add_player, id : ", str(id))
	#var player = player_scene.instantiate()
	#player.name = str(id)

func connected_to_server():
	add_player.rpc(PlayerData);

@rpc("any_peer", "call_local", "reliable")
func add_player(player_data : PlayerHandler):
	var player = player_scene.instantiate()
	var username : String = player_data.username
	player.name = str(player_data.id)
	player.player_name = username
	var max_length : int = "WWWWWWWWWWWWWWWW".length()
	player.name_label.text = "[center][font_size=100]" + (username if username.length() < max_length else username.substr(0, max_length))
	call_deferred("add_child", player)

extends Node2D

class_name Lobby

var default_port = 32400

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
@export var name_label: RichTextLabel

func _ready() -> void:
	add_player.rpc_id(1, name)
	#multiplayer.peer_connected.connect(add_peer)

func add_peer(id : int):
	add_player.rpc_id(id, id, name)

@rpc("any_peer", "call_remote", "reliable")
func add_player(username : String):
	var id : int = multiplayer.get_remote_sender_id();
	print("_add_player, id : ", str(id))
	var player = player_scene.instantiate()
	player.name = str(id)
	player.player_name = username
	var max_length : int = "WWWWWWWWWWWWWWWW".length();
	player.name_label.text = "[center][font_size=100]" + (username if username.length() < max_length else username.substr(0, max_length));
	call_deferred("add_child", player)
	#add_child(player)

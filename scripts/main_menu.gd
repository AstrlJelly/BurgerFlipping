extends Node2D

var default_port = 32400

var peer = ENetMultiplayerPeer.new()

@export var join_create_buttons: Node2D

@export var player_scene: PackedScene
@export var lobby_player_scene: PackedScene

@export var username_input: TextEdit
@export var create_port_input: TextEdit
@export var join_port_input: TextEdit

func _ready() -> void:
	#multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.peer_connected.connect(peer_connected)

func _on_create_game_pressed() -> void:
	var create_port : String = create_port_input.text
	var error = peer.create_server(int(create_port) if (create_port.length() > 0 and create_port.is_valid_int()) else default_port)
	if error:
		printerr(error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	
	#join_game()

func _on_join_game_pressed() -> void:
	var join_ip_port : String = join_port_input.text if join_port_input.text.length() > 0 else "localhost:" + str(default_port)
	var address_port : PackedStringArray = join_ip_port.split(':')
	if address_port.size() < 2 or !address_port[1].is_valid_int(): return
	
	peer.create_client(address_port[0], int(address_port[1]))
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	
	#join_game()


func peer_connected(id : int):
	send_player_data.rpc(id, username_input.text)

@rpc("any_peer", "call_local")
func send_player_data(id : int, username : String):
	if !PlayerData.Players.has(id):
		PlayerData.Players[id] = username

#func _on_join_game_pressed() -> void:
	#join_game()

#func _add_player(id : int = 1):
	#var name = username_input.text
	#lobby.add_player(name if name.length() > 0 else "Jimny_"+str(id))

#func join_game() -> void:
	#join_create_buttons.hide()
	#var username = username_input.text
	#PlayerData.id = multiplayer.get_unique_id()
	#PlayerData.username = username if username.length() > 0 else "Jimny_"+str(PlayerData.id)
	#set_multiplayer_authority(PlayerData.id)
	#var lobby_scene = load("res://assets/scenes/lobby.tscn").instantiate()
	#get_tree().root.add_child(lobby_scene)
	#self.hide()

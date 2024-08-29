extends Node2D

var default_port = 32400

var peer = ENetMultiplayerPeer.new()

@export var join_create_buttons: Node2D

@export var player_scene: PackedScene
@export var lobby_player_scene: PackedScene
@export var lobby_players_parent: Node

@export var username_input: TextEdit
@export var create_port_input: TextEdit
@export var join_port_input: TextEdit

func _ready() -> void:
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.peer_connected.connect(peer_connected)

func _on_create_game_pressed() -> void:
	var create_port : String = create_port_input.text
	var error = peer.create_server(int(create_port) if (create_port.length() > 0 and create_port.is_valid_int()) else default_port)
	if error:
		printerr(error)
		return
	setup_multiplayer()
	#connected_to_server()
	send_player_data(multiplayer.get_unique_id(), username_input.text)
	
	#var id = multiplayer.get_unique_id()
	#send_player_data(id, username_input.text)
	#add_player(id)
	
	#join_game()

func _on_join_game_pressed() -> void:
	var join_ip_port : String = join_port_input.text if join_port_input.text.length() > 0 else "localhost:" + str(default_port)
	var address_port : PackedStringArray = join_ip_port.split(':')
	if address_port.size() < 2 or !address_port[1].is_valid_int(): return
	
	var error = peer.create_client(address_port[0], int(address_port[1]))
	if error:
		printerr(error)
		return
	setup_multiplayer()
	#join_game()

func setup_multiplayer():
	join_create_buttons.hide()
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	
	#add_player(multiplayer.get_unique_id(), username_input.text)

func connected_to_server():
	var id : int = multiplayer.get_unique_id()
	send_player_data.rpc(id, username_input.text)
	#send_player_data.rpc_id(1, id, username_input.text)
	#add_player.rpc_id(1, id)

func peer_connected(id : int):
	#send_player_data.rpc(id, username_input.text)
	#send_player_data.rpc(id, username_input.text)
	pass

@rpc("any_peer", "call_remote")
func send_player_data(id : int, username : String):
	if username.length() <= 0:
		username = "Jimny_"+str(id)

	if !PlayerData.Players.has(id):
		var p = lobby_player_scene.instantiate()
		p.name = str(id)
		p.get_child(0).text = str(id)
		p.get_child(1).text = username
		lobby_players_parent.add_child(p)
		PlayerData.Players[id] = username
	
	if multiplayer.is_server():
		for pId in PlayerData.Players:
			send_player_data.rpc(pId, PlayerData.Players[pId])

@rpc("any_peer", "call_local")
func add_player(id : int):
	var username = PlayerData.Players[id]
	var player = player_scene.instantiate()
	player.name = str(id)
	print(player.name)
	player.player_name = username if username.length() > 0 else "Jimny_"+str(id)
	var max_length : int = "WWWWWWWWWWWWWWWW".length()
	player.name_label.text = "[center][font_size=100]" + (username if username.length() < max_length else username.substr(0, max_length))
	#call_deferred("add_child", player)
	add_child(player)

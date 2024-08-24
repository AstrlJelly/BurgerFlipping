extends Node2D

var default_port = 32400

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
@export var username_input: TextEdit
@export var create_port_input: TextEdit
@export var join_port_input: TextEdit

@export var lobby: Lobby

func _on_create_game_pressed() -> void:
	var create_port : String = create_port_input.text
	peer.create_server(int(create_port) if (create_port.length() > 0 and create_port.is_valid_int()) else default_port)
	multiplayer.multiplayer_peer = peer
	join_game()

func _on_join_game_pressed() -> void:
	var join_ip_port : String = join_port_input.text
	var address_port : PackedStringArray = join_ip_port.split(':')
	if address_port.size() < 2 or !address_port[1].is_valid_int(): return
	
	peer.create_client(address_port[0], int(address_port[1]))
	multiplayer.multiplayer_peer = peer
	join_game()

#func _on_join_game_pressed() -> void:
	#join_game()

#func _add_player(id : int = 1):
	#var name = username_input.text;
	#lobby.add_player(name if name.length() > 0 else "Jimny_"+str(id))

func join_game() -> void:
	var username = username_input.text;
	var lobby = load("res://assets/scenes/lobby.tscn").instantiate()
	get_tree().get_root().add_child(lobby)
	hide()
	var id : int = 1
	lobby.add_player(username if username.length() > 0 else "Jimny_"+str(id))

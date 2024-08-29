extends Node2D

var player_name : String = ""
@export var cursor : Node2D
@export var name_label : RichTextLabel

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_multiplayer_authority():
	#if get_multiplayer_authority() == multiplayer.get_unique_id():
		
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			cursor.position = get_global_mouse_position()
			#print(player_name);

extends Node2D

var player_name : String = ""
@export var cursor : Node2D
@export var name_label : RichTextLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_multiplayer_authority():
		cursor.position = get_global_mouse_position()
		
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			print(player_name);

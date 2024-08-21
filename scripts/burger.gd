extends Node

@export var sprite : Sprite2D
@export var cookTime : float = 5
var cookedPercentages : Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#sprite.material = mat.duplicate(true)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cookedPercentages.y += delta / cookTime;
	cookedPercentages = cookedPercentages.clamp(Vector2.ZERO, Vector2.ONE);
	print("sprite.Material cookedPercentages : ", sprite.material.get_shader_parameter("cookedPercentages"));
	sprite.material.set_shader_parameter("cookedPercentages", cookedPercentages);

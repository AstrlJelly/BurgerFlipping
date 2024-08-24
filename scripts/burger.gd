extends Node

class_name Burger

static var rawBurgers : Array[Texture2D]
static var cookedBurgers : Array[Texture2D]

@export var sprite : Sprite2D
@export var anim : AnimationPlayer
@export var cookTime : float = 5
var cookedPercentages : Vector2 = Vector2(0, 0)

func ready() -> void:
	# TODO: cache this stuff? not sure if there's a significant performance hit from accessing and setting stuff in init
	var rawBurgers : Array[Texture2D] = sprite.material.get_shader_parameter("rawBurgers")
	var cookedBurgers : Array[Texture2D] = sprite.material.get_shader_parameter("cookedBurgers")
	var rng = RandomNumberGenerator.new()
	#rng.randomize()
	var rawRand : int = rng.randi_range(0, rawBurgers.size())
	sprite.material.set_shader_parameter("whichRaw", rawRand)
	#rng.randomize()
	var cookedRand : int = rng.randi_range(0, rawBurgers.size())
	sprite.material.set_shader_parameter("whichCooked", cookedRand)
	print("rawRand == cookedRand : ", rawRand == cookedRand)

# not called automatically, but should be called in the _process of the file inheriting from it.
func process(delta: float) -> void:
	cookedPercentages.y += delta / cookTime
	cookedPercentages = cookedPercentages.clamp(Vector2.ZERO, Vector2.ONE)
	sprite.material.set_shader_parameter("cookedPercentages", cookedPercentages)

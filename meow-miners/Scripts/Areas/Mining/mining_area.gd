extends Node2D

var mining_pixel_load : PackedScene = load("res://Scenes/Areas/Mining/mining_pixel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_pixels()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Generates the mining pixels in the mining area
func generate_pixels() -> void:
	#print_debug(str($Background.scale.x) + " " + str($Background.scale.y))
	for i in $Background.scale.x:
		for j in $Background.scale.y:
			var mining_pixel = mining_pixel_load.instantiate()
			add_child(mining_pixel)
			mining_pixel.name = "mining_pixel_" + str(i) + "_" + str(j)
			mining_pixel.position = Vector2((i - $Background.scale.x/2) * 64 + 32, (j - $Background.scale.y/2) * 64 + 32)

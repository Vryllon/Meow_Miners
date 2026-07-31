extends Node2D

signal map_generated

var WIDTH: int = 100
var HEIGHT: int = 100

var mining_pixel_load : PackedScene = load("res://Scenes/Areas/Mining/mining_pixel.tscn")
var mining_map: Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("initialize_mining_map")

func initialize_mining_map() -> void:
	$Map.scale.x = WIDTH
	$Map.scale.y = HEIGHT
	mining_map = generate_mining_map()
	generate_pixels()
	map_generated.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Generates the data array containing the various materials in the mining area
func generate_mining_map() -> Array:
	var map: Array = []
	
	for i in WIDTH:
		# generate column
		var col: Array = []
		# fill column
		for j in $Map.scale.y:
			col.append(rand_mineral(i))
		
		# add this column to the map
		map.append(col)
	
	return map

# generates a random mineral based on the level and returns the int equivalent
func rand_mineral(level: int) -> int:
	var r: float = randf()
	if r <= 0.05:
		return 1
	
	return 0

# Generates the mining pixels in the mining area
func generate_pixels() -> void:
	for i in WIDTH:
		for j in HEIGHT:
			var mining_pixel = mining_pixel_load.instantiate()
			add_child(mining_pixel)
			mining_pixel.name = "mining_pixel_" + str(i) + "_" + str(j)
			mining_pixel.position = Vector2((i - HEIGHT/2) * 64 + 32, (j - WIDTH/2) * 64 + 32)
			mining_pixel.set_mineral(mining_map[i][j])

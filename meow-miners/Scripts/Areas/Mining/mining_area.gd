extends Node2D

signal map_generated

var WIDTH: int = 0
var HEIGHT: int = 0

var mining_pixel_load : PackedScene = load("res://Scenes/Areas/Mining/mining_pixel.tscn")
var mining_map: Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("initialize_mining_map")

func initialize_mining_map() -> void:
	WIDTH = $Map.scale.y
	HEIGHT = $Map.scale.x
	print_debug(HEIGHT)
	mining_map = generate_mining_map(1,HEIGHT)
	generate_pixels(1, HEIGHT)
	map_generated.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Generates the data array containing the various materials in the mining area
func generate_mining_map(start : int, end : int) -> Array:
	var map: Array = []
	
	for i in (end - start + 1):
		var level: Array = []
		
		# add level data
		level.append(start + i - 1)
		
		# add the data for each mining pixel at this level
		for j in $Map.scale.y:
			level.append(rand_mineral(start + i - 1))
		
		# add this level to the map
		map.append(level)
	
	return map

# generates a random mineral based on the level and returns the int equivalent
func rand_mineral(level: int) -> int:
	var r: float = randf()
	if r <= 0.05:
		return 1
	
	return 0

# Generates the mining pixels in the mining area
func generate_pixels(start: int, end: int) -> void:
	#print_debug(str($Background.scale.x) + " " + str($Background.scale.y))
	for i in WIDTH:
		for j in HEIGHT:
			var mining_pixel = mining_pixel_load.instantiate()
			add_child(mining_pixel)
			mining_pixel.name = "mining_pixel_" + str(i) + "_" + str(j)
			mining_pixel.position = Vector2((i - HEIGHT/2) * 64 + 32, (j - WIDTH/2) * 64 + 32)
			mining_pixel.set_mineral(mining_map[start+i-1][j+1])

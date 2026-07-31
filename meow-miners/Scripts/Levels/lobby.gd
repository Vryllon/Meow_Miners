extends Node2D

var player = load("res://Scenes/Characters/player.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mining_area_map_generated() -> void:
	var min = Vector2($Mining_Area.WIDTH, $Mining_Area.HEIGHT) * .25
	var mid = Vector2($Mining_Area.WIDTH, $Mining_Area.HEIGHT)/2
	var max = Vector2($Mining_Area.WIDTH, $Mining_Area.HEIGHT) * .75
	
	var rspawn = Vector2i(randi_range(min.x, max.x), randi_range(min.y, max.y))
	player.position = Vector2(rspawn.x - mid.x + 0.5, rspawn.y - mid.y + 0.5) * 64
	
	var spawn_tile = $Mining_Area.get_node("mining_pixel_" + str(rspawn.x) + "_" + str(rspawn.y))
	if spawn_tile: spawn_tile.mine()
	else: print_debug("ERROR: spawntile not found no spawn space alloted")
	
	add_child(player)

extends Node2D

var player = load("res://Scenes/Characters/player.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mining_area_map_generated() -> void:
	var rspawn = Vector2i(randi_range(0,$Mining_Area.WIDTH), randi_range(0,$Mining_Area.HEIGHT))
	player.position = Vector2(rspawn.x - $Mining_Area.WIDTH/2 + 0.5, rspawn.y - $Mining_Area.HEIGHT/2 + 0.5) * 64
	
	var spawn_tile = $Mining_Area.get_node("mining_pixel_" + str(rspawn.x) + "_" + str(rspawn.y))
	if spawn_tile: spawn_tile.mine()
	else: print_debug("ERROR: spawntile not found no spawn space alloted")
	
	add_child(player)

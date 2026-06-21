extends StaticBody2D

func set_mineral(mineral : int) -> void:
	match mineral:
		0: $Sprite2D.texture.gradient.colors[0] = Color("Green")
		1: $Sprite2D.texture.gradient.colors[0] = Color("Blue")
		_: print_debug("ERROR : Mineral data not found")

func mine() -> void:
	queue_free()

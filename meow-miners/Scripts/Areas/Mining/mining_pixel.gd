extends StaticBody2D

var mine_time: float = 10

func set_mineral(mineral : int) -> void:
	match mineral:
		0: init_mineral()
		1: init_mineral(Color("Blue"), 1)

func init_mineral(color: Color = Color("Dark_Gray"), mt: float = 0.5) -> void:
	mine_time = mt
	$Sprite2D.texture.gradient.colors[0] = color

func mine() -> void:
	queue_free()

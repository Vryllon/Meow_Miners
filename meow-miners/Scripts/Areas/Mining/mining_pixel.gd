extends StaticBody2D

var mine_time: float = 10
var mineral: int = -1

func set_mineral(mineral : int) -> void:
	match mineral:
		0: init_mineral()
		1: init_mineral(1, Color("Blue"), 1)

func init_mineral(m: int = 0, c: Color = Color("Dark_Gray"), mt: float = 0.5) -> void:
	mineral = m
	mine_time = mt
	$Sprite2D.texture.gradient.colors[0] = c

func mine() -> int:
	queue_free()
	return mineral

func discover() -> void:
	$Fog.hide()

extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func play() -> void:
	get_parent().play()


func _on_play_buton_pressed() -> void:
	play()
	print_debug("Play button clicked")

extends Node2D


func handle_player(enter: bool) -> void:
	$Interaction_Instruction.visible = enter

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.name.contains("Player"):
		handle_player(true)

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.name.contains("Player"):
		handle_player(false)

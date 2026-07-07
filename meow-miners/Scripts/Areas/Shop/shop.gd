extends Node2D

func handle_player(enter: bool) -> void:
	$Interaction_Instruction.visible = enter

func interact(player) -> void:
	for item in player.inv:
		var price = 0
		match item[0]:
			"stone": price = 1
			"bolk": price = 2
		player.currency += price * item[1]
	
	player.inv = []
	print_debug(player.currency)

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.name.contains("Player"):
		handle_player(true)

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body.name.contains("Player"):
		handle_player(false)

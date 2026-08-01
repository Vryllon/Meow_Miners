extends Control



func _ready() -> void:
	PlayerDataHandler.resource_data_updated.connect(update_resource_data_display)
	update_resource_data_display()

func update_resource_data_display() -> void:
	var resource_amounts = PlayerDataHandler.get_resource_data()
	$VBoxContainer/Stone.text = "Stone: " + str(resource_amounts[0])
	$VBoxContainer/Bolk.text = "Bolk: " + str(resource_amounts[1])

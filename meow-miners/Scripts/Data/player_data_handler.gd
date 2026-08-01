extends Node

var player_data = ""
signal resource_data_updated

func get_player_data():
	var file = FileAccess.open("user://player_data.dat", FileAccess.READ)
	if !file: save_player_data()
	
	print_debug("Player Data grabbed")
	player_data = file.get_as_text()
	resource_data_updated.emit()
	
	file.close()

func save_player_data(content: String = player_data):
	var file = FileAccess.open("user://player_data.dat", FileAccess.WRITE)
	file.store_string(content)
	print_debug("Player Data saved")
	file.close()

func _ready() -> void:
	clear_player_data()
	get_player_data()

func update_resource_data(resources : Array) -> void:
	var start_store_loc = player_data.find("resources")
	var current_resources = player_data.substr(player_data.find("[", start_store_loc), player_data.find("]", start_store_loc) - player_data.find("[", start_store_loc) + 1)
	player_data = player_data.replace(current_resources, str(resources))
	resource_data_updated.emit()
	save_player_data()

func get_resource_data() -> Array:
	var start_store_loc = player_data.find("resources")
	var current_resources = player_data.substr(player_data.find("[", start_store_loc), player_data.find("]", start_store_loc) - player_data.find("[", start_store_loc) + 1)
	return str_to_var(current_resources)

func clear_player_data() -> void:
	save_player_data("resources:[0, 0]")

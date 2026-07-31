extends CharacterBody2D


const SPEED = 300.0

var inv = []
var currency = 0

var mining: bool = false
var mining_obj: Object = null
var mining_prev: Object = null
var mining_time: float = 0


func _input(event: InputEvent) -> void:
	if event.is_action("mine"):
		if event.is_action_pressed("mine"):
			mining = true
			set_mine_target()
		if event.is_action_released("mine"):
			mining = false
			mining_obj= null
	
	if event.is_action_pressed("interact"):
		for area in $Area2D.get_overlapping_areas():
			if area.name.contains("Interaction"):
				area.get_parent().interact(self)
		

func _physics_process(delta: float) -> void:
	handle_move(delta)
	handle_ray()
	handle_mining(delta)

# Function that handles movement updates during physics_process
func handle_move(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("move_left", "move_right")
	var directiony := Input.get_axis("move_up", "move_down")
	
	velocity.x = directionx
	velocity.y = directiony
	
	velocity = velocity.normalized() * SPEED

	move_and_slide()

# Function that handles player to mouse ray during physics_process
func handle_ray() -> void:
	$RayCast2D.target_position = (get_global_mouse_position() - global_position).normalized() * 128
	$RayCast2D/Mine_Line.set_point_position(1, $RayCast2D.target_position)
	var focus = $RayCast2D.get_collider()
	if focus and focus.get_name().contains("mining_pixel"): focus.discover()

# Function that handles mining
func handle_mining(delta: float) -> void:
	set_mine_target()
	# Check if the same pixel is being mine as the previous check
	if mining_obj and (mining_prev == null or mining_obj == mining_prev):
		mining_time += delta
	else:
		mining_time = 0
		return
	
	#print_debug(mining_time)
	
	# If mining_objtime has exceeded pixels mine time then mine the pixel
	if mining_time >= mining_obj.mine_time:
		add_to_inv(mining_obj.mine())

func add_to_inv(mineral: String) -> void:
	# Add to existing slot if mineral has already been gathered
	for slot in inv:
		if slot[0] == mineral:
			slot[1] += 1
			return
	
	# Add new slot if new item
	inv.append([mineral, 1])

func set_mine_target() -> void:
	# Update previous mined pixel
	mining_prev = mining_obj
	
	# Set current mine target
	var collision: Object = $RayCast2D.get_collider()
	if mining and collision and collision.get_name().contains("mining_pixel"):
		mining_obj= collision
	else: mining_obj= null

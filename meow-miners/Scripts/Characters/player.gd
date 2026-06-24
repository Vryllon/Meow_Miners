extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

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

func _physics_process(delta: float) -> void:
	handle_move(delta)
	handle_ray()
	handle_mining(delta)

# Function that handles movement updates during physics_process
func handle_move(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Function that handles player to mouse ray during physics_process
func handle_ray() -> void:
	$RayCast2D.target_position = get_global_mouse_position() - global_position

# Function that handles mining
func handle_mining(delta: float) -> void:
	# Check if the same pixel is being mine as the previous check
	if mining_obj and (mining_prev == null or mining_obj== mining_prev):
		mining_time += delta
	else:
		mining_time = 0
		set_mine_target()
		return
	
	print_debug(mining_time)
	
	# If mining_objtime has exceeded pixels mine time then mine the pixel
	if mining_time >= mining_obj.mine_time:
		mining_obj.mine()
	
	# Update previous mined pixel
	mining_prev = mining_obj

func set_mine_target() -> void:
	var collision: Object = $RayCast2D.get_collider()
	if mining and collision and collision.get_name().contains("mining_pixel"):
		mining_obj= collision
	else: mining_obj= null

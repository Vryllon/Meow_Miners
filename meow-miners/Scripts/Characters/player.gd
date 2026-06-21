extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mine"):
		print_debug("mine")
		var collision: Object = $RayCast2D.get_collider()
		if collision && collision.get_name().contains("mining_pixel"):
			collision.mine()

func _physics_process(delta: float) -> void:
	handle_move(delta)
	handle_ray()

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

extends CharacterBody3D

const SPEED = -0.5
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.0005

var direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * MOUSE_SENSITIVITY

func _physics_process(delta: float) -> void:
	# Handle gravity.
	if not is_on_floor():
		velocity.y -= delta * ProjectSettings.get_setting("physics/3d/default_gravity")
	else:
		velocity.y = 0

	# Handle jumping.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	direction = Vector3.ZERO
	if Input.is_action_pressed("walk"):
		direction -= transform.basis.z.normalized()

	# Apply movement in the forward direction.
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	# Move the character.
	move_and_slide()

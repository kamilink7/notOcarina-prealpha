extends CharacterBody3D


@export var SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var camera: Node3D = $CamRig/Camera3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("manjump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("moveleft", "moveright", "moveup", "movedown")
	var direction := (camera.global_basis * Vector3(input_dir.x, 0, input_dir.y))
	direction = Vector3(direction.x, 0, direction.z).normalized() * input_dir.length()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	turn_to(direction)
	
func turn_to(direction: Vector3) -> void:
	if direction:
		var yaw = atan2(-direction.x, -direction.z)
		yaw = lerp_angle(rotation.y, yaw, 0.1)
		rotation.y = yaw

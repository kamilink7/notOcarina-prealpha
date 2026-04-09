extends SpringArm3D

@onready var camera: Camera3D = $Camera3D
@export var turn_rate:= 200
var mouse_input : Vector2 = Vector2()
@onready var player: Node3D = get_parent()
var camera_rig_height: float = position.y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spring_length = camera.position.z
	# For later: input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cam_input:= Input.get_vector("camleft","camright","camup","camdown")
	cam_input = turn_rate * cam_input * delta
	rotation_degrees.x += -cam_input.y
	rotation_degrees.y += -cam_input.x
	rotation_degrees.x = clampf(rotation_degrees.x, -60, 60)

func _physics_process(delta: float) -> void:
	position = player.position + Vector3(0, camera_rig_height, 0)

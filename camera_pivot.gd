extends Node3D

@export var target : Node3D
@export var rotation_speed : float = 2.0
@export var zoom_speed : float = 1.0

var rotation_input : float = 0.0
var tilt_input : float = 0.0

func _process(delta: float) -> void:
	if target:
		# Keep pivot at target's position
		global_position = target.global_position
	
	# Rotate Y (Horizontal) and X (Vertical/Tilt)
	rotate_y(rotation_input * rotation_speed * delta)
	rotation.x = clamp(rotation.x + tilt_input * rotation_speed * delta, deg_to_rad(-60), deg_to_rad(0))
	
	# Reset input for next frame
	rotation_input = 0.0
	tilt_input = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion and Input.get_axis("ui_camleft", "ui_camright") or Input.get_axis("ui_camup", "ui_camdown"):
		rotation_input = -Input.get_axis("ui_camleft", "ui_camright")
		tilt_input = -Input.get_axis("ui_camup", "ui_camdown")

extends Node3D

@export var camera: Camera3D
var zoom_sensitivity := 20.0
var rotate_sensitivity := 0.1
var pan_sensitivity := 0.005


func _ready():
	camera.look_at(self.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.look_at(self.position)
	var camera_zoom = int(Input.is_action_just_released("camera_zoom_down")) - int(Input.is_action_just_released("camera_zoom_up"))
	camera.position += camera.basis.z * camera_zoom * zoom_sensitivity * delta


func _input(event):
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("rotate_cam"):
			#camera.position = camera_initial_position
			self.rotation_degrees.y += event.relative.x * rotate_sensitivity
		if Input.is_action_pressed("pan_cam"):
			var pan_dir = transform.basis.x * event.relative.x - transform.basis.y * event.relative.y
			self.position -= pan_dir * pan_sensitivity

func go_to_target(target_pos: Vector3):
	position = target_pos

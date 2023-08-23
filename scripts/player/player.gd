extends CharacterBody3D

const SPEED = 1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var camera: Camera3D
var camera_initial_position: Vector3
var zoom_sensitivity := 20.0
var rotate_sensitivity := 0.1
var pan_sensitivity := 0.01

func _ready():
	camera.look_at(self.position)
	camera_initial_position = camera.position

func _input(event):
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("rotate_cam"):
			camera.position = camera_initial_position
			camera.look_at(self.position)
			self.rotation_degrees.y += event.relative.x * rotate_sensitivity
		if Input.is_action_pressed("pan_cam"):
			camera.position -= (camera.transform.basis.x * event.relative.x - camera.transform.basis.y * event.relative.y) * pan_sensitivity

func _physics_process(delta):
	var camera_zoom = int(Input.is_action_just_released("camera_zoom_down")) - int(Input.is_action_just_released("camera_zoom_up"))
	camera.position += camera.basis.z * camera_zoom * zoom_sensitivity * delta
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (self.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED /5 )
		velocity.z = move_toward(velocity.z, 0, SPEED /5)

	move_and_slide()

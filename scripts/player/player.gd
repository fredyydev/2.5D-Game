extends CharacterBody3D

const SPEED = 1.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var anim_tree := $AnimationTree
@export var camera: Node3D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED /5)
		velocity.z = move_toward(velocity.z, 0, SPEED /5)
	
	update_animation_params(input_dir)
	move_and_slide()


func update_animation_params(direction):
	anim_tree["parameters/conditions/is_idle"] = (direction == Vector2.ZERO)
	anim_tree["parameters/conditions/is_walking"] = (direction != Vector2.ZERO)
	if direction != Vector2.ZERO:
		anim_tree["parameters/Idle/blend_position"] = direction
		anim_tree["parameters/Walk/blend_position"] = direction




extends StaticBody3D

var mouse_in: bool

func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		get_tree().call_group("camera-rig", "go_to_target", global_position)

func _on_mouse_entered():
	mouse_in = true


func _on_mouse_exited():
	mouse_in = false

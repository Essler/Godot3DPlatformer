extends Camera3D


var _mouse_position = Vector2(0,0)
var _zoom = 5.0

func _process(delta):
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		pass
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var yaw = _mouse_position.x
		var pitch = _mouse_position.y
		_mouse_position = Vector2(0,0)
		#global_rotation.angle_to(Vector3(0,90,0))
		rotate_y(deg_to_rad(yaw))
		rotate_object_local(Vector3.RIGHT, deg_to_rad(pitch))


func _input(event):s
	if event is InputEventMouseMotion:
		_mouse_position = event.relative
	
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			MOUSE_BUTTON_WHEEL_UP:
				_zoom = clamp(_zoom + 1.0, 0.0, 100.0)
			MOUSE_BUTTON_WHEEL_DOWN:
				_zoom = clamp(_zoom - 1.0, 0.0, 100.0)

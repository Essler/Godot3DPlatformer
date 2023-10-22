extends Area3D


var spin_speed = 2.0
var bob_height = 0.2
var bob_speed = 5.0

@export var value = 10

@onready var start_y = global_position.y
var t = 0.0


func _process(delta):
	# Spin
	rotate(Vector3.UP, spin_speed * delta)
	
	# Bounce
	t += delta
	var d = (sin(t * bob_speed) + 1) / 2
	global_position.y = start_y + (d * bob_height)


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.add_score(value)
		queue_free()

extends CharacterBody3D


var move_speed = 4.0
var jump_velocity = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var facing_angle = 0.0
var just_jumped = false
var has_climbing_boots = true
var has_double_jump = true
var score = 0

@onready var model  = get_node("CharacterVampire")
@onready var debug_text : Label = get_node("CanvasLayer/DebugInfo")
@onready var score_text : Label = get_node("CanvasLayer/ScoreText")


func _process(_delta):
	score_text.text = str("Score: ", score)
	debug_text.text = "state: "
	if is_on_floor(): debug_text.text += "is_on_floor "
	if is_on_wall(): debug_text.text += "is_on_wall "
	if is_on_ceiling(): debug_text.text += "is_on_ceiling"


func _physics_process(delta):
	if not is_on_floor():
		just_jumped = false
		
	if not is_on_floor() and (has_climbing_boots and not is_on_wall()):
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor()  or (has_climbing_boots and is_on_wall()):
			just_jumped = true
			velocity.y = jump_velocity
		if (has_double_jump and just_jumped):
			velocity.y = jump_velocity
	
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var dir = Vector3(input.x, 0, input.y)
	
	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed

	move_and_slide()
	
	if input.length() > 0:
		facing_angle = Vector2(input.y, input.x).angle()
	
	model.rotation.y = lerp_angle(model.rotation.y, facing_angle, 0.2)
	
	if position.y < -5:
		game_over()


func add_score(amount):
	score += amount


func game_over():
	get_tree().reload_current_scene()

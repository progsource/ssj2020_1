extends KinematicBody2D


export(int) var run_speed = 200
export(int) var jump_speed = -400
export(int) var gravity = 1200
export(float, 0, 1, 0.01) var friction = 0.01
export(float, 0, 1, 0.1) var acceleration = 0.5

var is_paused : bool = false
var velocity = Vector2()
var jumping = false
var direction : float = 0.0


func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("virus", "set_player", self)


func _input(_event):
	if is_paused:
		return

	velocity.x = 0

	var jump = Input.is_action_just_pressed('ui_select')
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	
	if is_on_floor():
		direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if direction != 0:
		# accelerate when there's input
		velocity.x = lerp(velocity.x, direction * run_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)


func _physics_process(delta):
	if is_paused:
		return

	velocity.y += gravity * delta
	
	if jumping and is_on_floor():
		jumping = false
	
	velocity = move_and_slide(velocity, Vector2(0, -1))


func _on_update_game_state(var is_game_paused : bool):
	is_paused = is_game_paused
	

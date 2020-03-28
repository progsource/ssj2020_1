extends KinematicBody2D


export(int) var run_speed = 100
export(int) var jump_speed = -400
export(int) var gravity = 1200

var is_paused : bool = false
var velocity = Vector2()
var jumping = false


func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("virus", "set_player", self)


func _input(_event):
	if is_paused:
		return
	
	var direction : float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * run_speed
	
	var jump = Input.is_action_just_pressed('ui_select')
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed


func _physics_process(delta):
	if is_paused:
		return

	#velocity.x *= delta
	velocity.y += gravity * delta
	
	if jumping and is_on_floor():
		jumping = false
	
	velocity = move_and_slide(velocity, Vector2(0, -1))


func _on_update_game_state(var is_game_paused : bool):
	is_paused = is_game_paused
	

extends KinematicBody2D


signal player_moved(pos_x)


enum State {IDLE, RUNNING, JUMPING}


export(int) var run_speed = 200
export(int) var jump_speed = -400
export(int) var gravity = 1200
export(float, 0, 1, 0.01) var friction = 0.01
export(float, 0, 1, 0.1) var acceleration = 0.5

var is_paused : bool = false
var velocity = Vector2()
var direction : float = 0.0
var current_state = State.IDLE


func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("virus", "set_player", self)
	$AnimationPlayer.play("PlayerIdle")
	# warning-ignore:return_value_discarded
	EventBus.connect("item_picked_up", self, "_on_item_pickup")
	# warning-ignore:return_value_discarded
	EventBus.connect("objective_completed", self, "_on_objective_completed")


func _input(_event):
	if is_paused:
		return

	velocity.x = 0

	var jump = Input.is_action_just_pressed('ui_select')
	
	if jump and is_on_floor():
		current_state = State.JUMPING
		velocity.y = jump_speed
		$JumpSound.play()
	
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

	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	emit_signal("player_moved", position.x)
	
	if current_state == State.JUMPING and is_on_floor():
		current_state = State.IDLE
		direction = 0
		$LandSound.play()
	elif is_on_floor() and velocity.x == 0:
		current_state = State.IDLE
	elif velocity.x > 0 or velocity.x < 0:
		current_state = State.RUNNING


func _process(_delta):
	_play_animation()


func _on_update_game_state(var is_game_paused : bool):
	is_paused = is_game_paused
	

func _play_animation():
	$Sprite.flip_h = direction < 0
	
	if current_state == State.IDLE:
		$AnimationPlayer.play("PlayerIdle")
	elif current_state == State.RUNNING:
		$AnimationPlayer.play("PlayerRun")
	elif current_state == State.JUMPING:
		$AnimationPlayer.play("PlayerJump")


func _on_item_pickup(var _instance_id):
	$CollectItemSound.play()

func _on_objective_completed(_sender_id, _path) -> void:
	current_state = State.IDLE
	is_paused = true

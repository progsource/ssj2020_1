extends KinematicBody2D


export(float, 10, 300, 0.01) var speed : float = 40.0


var is_paused : bool = false
var direction : float = 0.0


func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("virus", "set_player", self)

func _input(_event):
	if is_paused:
		return
	
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")


func _physics_process(delta):
	if is_paused:
		return

	var force_x : float = direction * speed * delta
	var force = Vector2(force_x, 0)
	var collision = move_and_collide(force)
	
	if collision:
		print("collided")

func _on_update_game_state(var is_game_paused : bool):
	is_paused = is_game_paused
	

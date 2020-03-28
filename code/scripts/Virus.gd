extends KinematicBody2D

export(int, 32, 64, 1) var infection_cast_to_y : int = 32
export(int, 72, 144, 1) var chase_cast_to_y : int = 72
export(float, 3, 15.0, 0.1) var chase_boost : float = 5.0

onready var infection_range = [$InfectionRange1, $InfectionRange2]
onready var chase_range = [$ChaseRange1, $ChaseRange2]

onready var animation_player = $AnimationPlayer

var player = null
var speed : float = 0.0

func _ready() -> void:
	add_to_group("virus")
	animation_player.play("Move")

	# warning-ignore:return_value_discarded
	EventBus.connect("objective_completed", self, "_on_objective_completed")

	for infection in infection_range:
		infection.set_cast_to(Vector2(0, infection_cast_to_y))
	for chase in chase_range:
		chase.set_cast_to(Vector2(0, chase_cast_to_y))

func _on_objective_completed(_sender_id, _path) -> void:
	_disable_range()

func _disable_range() -> void:
	for infection in infection_range:
		infection.set_enabled(false)
	for chase in chase_range:
		chase.set_enabled(false)

func _physics_process(delta) -> void:
	if player == null:
		return

	_check_infection_range()
	_check_chase_range(delta)

func _check_chase_range(delta) -> void:
	for ray in chase_range:
		if ray.is_colliding():
			var coll = ray.get_collider()
			if coll.name == player.name:
				_move(delta)

func _move(delta) -> void:
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	global_rotation = atan2(vec_to_player.y, vec_to_player.x)
	# warning-ignore:return_value_discarded
	move_and_collide(vec_to_player * speed * delta)

func _check_infection_range() -> void:
	for ray in infection_range:
		if ray.is_colliding():
			var coll = ray.get_collider()
			if coll.name == player.name:
				EventBus.emit_signal("infected", get_instance_id())

func set_player(p) -> void:
	player = p
	speed = p.run_speed + chase_boost

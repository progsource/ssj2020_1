extends "res://scripts/Virus.gd"

onready var shape := $CollisionShape2D

func _ready():
	._disable_range()

func _check_infection_range() -> void:
	pass

func _check_chase_range(delta) -> void:
	var collision = ._chase(delta) as KinematicCollision2D

	if collision && collision.get_collider_id() == player.get_instance_id():
		shape.call_deferred("set_disabled", true)
		EventBus.emit_signal("infected", get_instance_id())
		queue_free()

func _disable_collision() -> void:
	shape.call_deferred("set_disabled", true)

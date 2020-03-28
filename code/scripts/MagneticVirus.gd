extends "res://scripts/Virus.gd"

func _ready():
	._ready()
	for infection in infection_range:
		infection.set_enabled(false)
	for chase in chase_range:
		chase.set_enabled(false)

func _check_infection_range() -> void:
	pass

func _check_chase_range(delta) -> void:
	pass

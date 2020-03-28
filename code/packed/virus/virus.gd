# virus.gd
extends KinematicBody2D

signal infected

onready var infection_range = [$InfectionRayLeft, $InfectionRayRight]

onready var animation_player = $AnimationPlayer

var player = null

func _ready():
	add_to_group("virus")

func _physics_process(_delta):
	if player == null:
		return

	for ray in infection_range:
		if ray.is_colliding():
			var coll = ray.get_collider()
			if coll.name == player.name:
				print("infected")
				emit_signal("infected")

func set_player(p):
	player = p
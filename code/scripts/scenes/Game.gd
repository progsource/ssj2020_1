extends Node2D



func _ready():
	print("show start popup")
	print("load level")
	# warning-ignore:return_value_discarded
	$Player.connect("player_moved", $Platforms/Platform, "_on_player_moved")
	# warning-ignore:return_value_discarded
	$Player.connect("player_moved", $Background, "_on_player_moved")



func _process(_delta):
	pass


func _on_start_button_pressed():
	print("start the game")


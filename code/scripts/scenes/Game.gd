extends Node2D



func _ready():
	print("show start popup")
	print("load level")
	# warning-ignore:return_value_discarded
	$Player.connect("player_moved", $Platforms/Platform, "_on_player_moved")



func _process(_delta):
	print("make level move based on player")


func _on_start_button_pressed():
	print("start the game")


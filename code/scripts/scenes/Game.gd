extends Node2D



func _ready():
	print("show start popup")
	print("load level")



func _process(_delta):
	print("make level move based on player")


func _on_start_button_pressed():
	print("start the game")

func _get_configuration_warning() -> String:
	return "SceneLoader is mandatory!" if not $SceneLoader else ""

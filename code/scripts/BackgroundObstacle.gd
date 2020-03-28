extends Sprite


func _ready():
	# warning-ignore:return_value_discarded
	$VisibilityNotifier2D.connect("screen_exited", self, "_on_screen_exit")


func _on_screen_exit() -> void :
	print("nice try - check out https://github.com/godotengine/godot/issues/4803")

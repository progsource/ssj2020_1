extends Sprite


func _ready():
	# warning-ignore:return_value_discarded
	$VisibilityNotifier2D.connect("camera_exited", self, "_on_screen_exit")


func _on_screen_exit(var cam : Camera) -> void :
	if cam.current:
		queue_free()

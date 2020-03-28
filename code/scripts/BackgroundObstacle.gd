extends Sprite


func _ready():
	$VisibilityNotifier2D.connect("screen_exited", self, "_on_screen_exit")


func _on_screen_exit():
	queue_free()

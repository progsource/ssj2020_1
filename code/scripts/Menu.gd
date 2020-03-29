extends Control

export(String, FILE) var next_level_file_path := ""
export(String, MULTILINE) var text = ""

onready var note = $Margin/Box/Note

func _ready():
	note.set_text(text)

func _on_Start_pressed():
	print("start")
	EventBus.emit_signal("objective_completed", get_instance_id(), next_level_file_path)

func _on_Quit_pressed():
	get_tree().quit() 

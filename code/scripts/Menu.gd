extends Control


export(String, FILE) var next_level_file_path := ""
export(String, MULTILINE) var text = ""
export(Texture) var logo = preload("res://assets/gfx/hud/gui_game_logo.png")


onready var note = $Margin/Box/Note




func _ready():
	note.set_text(text)
	$Margin/Box/Logo.texture = logo
	
	if OS.has_feature('JavaScript'):
		$Margin/Box/Buttons/Quit.visible = false

func _on_Start_pressed():
	GlobalData.selected_character = GlobalData.CharacterSelection.GIRL
	EventBus.emit_signal("objective_completed", get_instance_id(), next_level_file_path)


func _on_start_boy_pressed():
	GlobalData.selected_character = GlobalData.CharacterSelection.BOY
	EventBus.emit_signal("objective_completed", get_instance_id(), next_level_file_path)

func _on_Quit_pressed():
	get_tree().quit() 

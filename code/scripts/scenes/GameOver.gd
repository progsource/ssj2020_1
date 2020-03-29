extends CanvasLayer


const girl_texture = preload("res://assets/gfx/player/player_girl.png")
const boy_texture = preload("res://assets/gfx/player/player_guy.png")


func _ready():
	if GlobalData.selected_character == GlobalData.CharacterSelection.GIRL:
		$DeadChar.texture = girl_texture
	else:
		$DeadChar.texture = boy_texture


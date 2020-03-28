tool
extends StaticBody2D


export(Vector2) var size = Vector2(128, 32) setget set_size


func set_size(var s : Vector2) -> void :
	size = s
	_resizePlatform()


func _ready():
	_resizePlatform()


func _resizePlatform():
	$NinePatchRect.rect_size = size
	var pos = $NinePatchRect.rect_position
	var points = PoolVector2Array([
		Vector2(pos.x, pos.y + size.y),
		pos,
		Vector2(pos.x + size.x, pos.y),
		Vector2(pos.x + size.x, pos.y + size.y),
	])
	
	$CollisionPolygon2D.polygon = points


func _on_player_moved(var pos_x : float) -> void :
	position.x = pos_x

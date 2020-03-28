extends StaticBody2D


export(Vector2) var size = Vector2(128, 32) 

func _ready():
	$NinePatchRect.rect_size = size
	var pos = $NinePatchRect.rect_position
	var points = PoolVector2Array([
		Vector2(pos.x, pos.y + size.y),
		pos,
		Vector2(pos.x + size.x, pos.y),
		Vector2(pos.x + size.x, pos.y + size.y),
	])
	
	$CollisionPolygon2D.polygon = points

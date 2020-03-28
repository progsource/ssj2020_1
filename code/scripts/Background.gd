extends ParallaxBackground


enum ObstacleType { EMPTY, LIGHT, SHELF, VEGGIES, COUNT }


class Obstacle:
	var type : int
	var position_x : float


const block_size : float = 320.0
const view_offset : float = 180.0
const light_texture = preload("res://assets/gfx/background/ceiling_light.png")
const shelf_texture = preload("res://assets/gfx/background/shelfs_crumbled.png")
const veggies_texture = preload("res://assets/gfx/background/shelfs_veggies.png")
const obstacle_scene = preload("res://packed/BackgroundObstacle.tscn")
# y positions
const obstacle_definitions = {
	ObstacleType.LIGHT : 96.0,
	ObstacleType.SHELF : 160.0,
	ObstacleType.VEGGIES : 160.0,
}


var obstacles = {}
var lights = {}
var visible_object = []
var visible_lights = []
var player_position_x : float = 0
var rng = RandomNumberGenerator.new()


func _ready():
	rng.seed = OS.get_unix_time()
	rng.randomize()


func _process(_delta):
	var current_block_position = floor(player_position_x / block_size)
	
	if obstacles.has(current_block_position) and !_is_obstacle_visible(current_block_position):
		_create_obstacle(current_block_position, obstacles.get(current_block_position))
	elif !obstacles.has(current_block_position):
		var type = rng.randi_range(0, ObstacleType.COUNT - 1)
		_create_obstacle(current_block_position, type)


func _on_player_moved(var pos_x : float) -> void :
	player_position_x = pos_x - view_offset


func _is_obstacle_visible(var block_position : float) -> bool :
	for o in visible_object:
		if o and o.position_x == block_position:
			return true
	return false


func _create_obstacle(var pos_x : float, var type : int) -> void :
	if type == ObstacleType.EMPTY:
		return

	var obstacle = obstacle_scene.instance()
	obstacle.position.x = pos_x * block_size + view_offset
	obstacle.position.y = obstacle_definitions[type]
	if type == ObstacleType.LIGHT:
		obstacle.texture = light_texture
	elif type == ObstacleType.SHELF:
		obstacle.texture = shelf_texture
	elif type == ObstacleType.VEGGIES:
		obstacle.texture = veggies_texture
	
	var vo = Obstacle.new()
	vo.position_x = pos_x
	vo.type = type
	visible_object.push_back(vo)
	
	obstacles[pos_x] = type
	
	$ObstacleParallaxLayer.add_child(obstacle)

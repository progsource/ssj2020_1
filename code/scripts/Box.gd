tool
extends Node2D


enum BoxSize { ONE, TWO, THREE, FOUR }


export(BoxSize) var box_size = BoxSize.ONE setget set_box_size


var boxes : Array
var are_boxes_initialized : bool = false


func _ready():
	_update_box()


func set_box_size(var size : int) -> void :
	box_size = size
	_update_box()


func _update_box() -> void :
	_init_boxes()

	for box in boxes:
		box.visible = false
		box.get_node("CollisionShape2D").disabled = true
	
	boxes[box_size].visible = true
	boxes[box_size].get_node("CollisionShape2D").disabled = false


func _init_boxes() -> void :
	if are_boxes_initialized:
		return

	boxes.push_back($Box1)
	boxes.push_back($Box2)
	boxes.push_back($Box3)
	boxes.push_back($Box4)
	are_boxes_initialized = true

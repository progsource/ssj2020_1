extends NinePatchRect

const TEMPLATE : String = "%03d"
onready var counter = $Label
var count = 0

func _ready():
	EventBus.connect("item_picked_up", self, "_on_item_picked_up")

func _on_item_picked_up(_sender_id):
	count += 1
	counter.text = TEMPLATE % count

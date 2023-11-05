extends StaticBody2D

var is_growing = true
var progress = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Growing").position.y += 600


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress >= 2800:
		is_growing = false
	if is_growing:
		progress += 1
		get_node("Growing").position.y -= 0.2
		get_node("Adult").hide()
		get_node("Growing").play("growing")
	else:
		get_node("Growing").hide()
		get_node("Adult").show()
		get_node("Adult").play("adult")
	pass

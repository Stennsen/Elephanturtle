extends StaticBody2D

var is_growing = true
var progress = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress >= 3000:
		is_growing = false
	if is_growing:
		progress += 1
		get_node("Growth").play("growing")
	else:
		get_node("Growth").play("adult")
	pass

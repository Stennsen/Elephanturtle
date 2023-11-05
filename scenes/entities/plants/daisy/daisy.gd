extends Area2D


@onready var crop_sound = $crop_sound
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
'''signal flower_cropped

func _on_interaction():
	# Your logic for handling the interaction (e.g., play animations, effects, etc.)
	# Then, emit the signal to indicate that the flower has been cropped
	emit_signal("flower_cropped")'''


# Called every frame. 'delta' is the elapsed time since the previous frame.
'''func destroy_area():
	get_parent().get_node("").queue_free()'''

func _input(event):
	if event.is_action_pressed("crop"):  # Check if the "E" key is pressed
		crop_sound.play()
		queue_free()
		print("cropped")

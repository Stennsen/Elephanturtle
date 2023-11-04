extends Area2D


@onready var crop_sound = $crop_sound
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event):
	if event.is_action_pressed("crop"):  # Check if the "E" key is pressed
		crop_sound.play()
		print("cropped")

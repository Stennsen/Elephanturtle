extends Area2D


@onready var crop_sound = $crop_sound
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func destroy_area():
	queue_free()

func _input(event):
	if event.is_action_pressed("crop"):  # Check if the "E" key is pressed
		crop_sound.play()
		destroy_area()
		print("cropped")

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
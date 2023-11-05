extends Area2D

const WEIGHT = 0.1

@onready var crop_sound = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.



func _input(event):
	if event.is_action_pressed("crop"):  # Check if the "E" key is pressed
		crop_sound.play()
		get_tree().call_group("Daisy", "destroy")
		# Remove the object from the group
		remove_from_group("Daisy")
		# Destroy the object
		queue_free()

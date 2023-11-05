extends CharacterBody2D


const SPEED = 650.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var original_position

@onready var ghost_sprite = $Ghost
@onready var animation_player = $AnimationPlayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("crop"):
		# Get the list of daisies
		var dw = get_tree().get_first_node_in_group("Disc World")
		var daisies = dw.flower_list
		if daisies != null:
			# Loop through the daisies
			for daisy in daisies:
				# Check if the player is colliding with the daisy
				if daisy.overlaps_area(get_node("Area2D")):
					# Emit the "crop" signal
					dw._on_crop_daisy(daisy)
func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	animation_player.play("float")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x >= 0:
		ghost_sprite.flip_h = false 
	else:
		ghost_sprite.flip_h = true 

	move_and_slide()
	

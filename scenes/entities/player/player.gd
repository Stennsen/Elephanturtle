extends CharacterBody2D


const SPEED = 650.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var original_position

@onready var ghost_sprite = $Ghost


func _ready():
	original_position = position

func _physics_process(delta):
	# Add the gravity.
	'''if not is_on_floor():
		velocity.y += gravity * delta'''

	# floating by moving the sprite up and down
	
	
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x >= 0:
		ghost_sprite.flip_h = false 
	else:
		ghost_sprite.flip_h = true 

	move_and_slide()



		


func _on_plant_1_body_entered(body):
	if body.is_in_group("Ghost"):
		print("touched plant - could be cropped with E")
		
			

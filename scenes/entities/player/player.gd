extends CharacterBody2D


const SPEED = 650.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var original_position

@onready var ghost_sprite = $Ghost
@onready var animation_player = $AnimationPlayer

#func _ready():
	# Connect the body_entered signal of each Area2D node in the parent node to the player's script
	#get_node("ParentNode").connect("node_added", self, "on_node_added")

func on_node_added(node):
	if node is Area2D:
		node.connect("body_entered", self, "on_area2d_body_entered")

func on_area2d_body_entered(area):
	# Handle the collision event
	print("Collision detected with ", area.name)

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
	

extends Node2D

# Spacing of the zones on the map, to calculate the weight modifier
const ZONE_SPACING = 500

# the maximum +/- value for balance
const MAX_INBALANCE = 0.35

# tracks the balance of the world
var balance = 0;

func calculate_balance():
	# calculate node weights with modifiers
	player_x = get_node("Player").global_position.x

	# set new balance
	balance = balance + 0.1


func rotate_camera():
	var camera = get_node("Camera2d")
	var cur_rotation = camera.global_rotation
	var roation_diff = cur_rotation - balance
	camera.rotate(rotation_diff/100)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	calculate_balance()
	pass

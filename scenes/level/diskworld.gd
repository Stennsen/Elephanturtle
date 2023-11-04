extends Node2D


const ZONE_SPACING = 500	# Spacing of the zones on the map, to calculate the weight modifier
const MAX_INBALANCE = 0.45	# the maximum +/- value for balance until gameover
const INBALANCE_MOVEMENT_DIVIDER = 100	# dictates the tipping speed of the platform 

# tracks the balance of the world
var balance = -0.45;

# func calculate_balance():
# 	# calculate node weights with modifiers
# 	player_x = get_node("Player").global_position.x
# 
# 	# set new balance
# 	balance = balance + 0.1


func rotate_camera():
	var camera = get_node("Camera2D")
	var cur_rotation = camera.global_rotation
	var rotation_diff = balance - cur_rotation
	camera.rotate(rotation_diff/INBALANCE_MOVEMENT_DIVIDER)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#calculate_balance()
	rotate_camera()
	pass

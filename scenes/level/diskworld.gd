extends Node2D


const ZONE_SPACING = 500	# Spacing of the zones on the map, to calculate the weight modifier
const MAX_INBALANCE = 0.45	# the maximum +/- value for balance until gameover
const INBALANCE_MOVEMENT_DIVIDER = 100	# dictates the tipping speed of the platform 

@export var daisy_scene: PackedScene

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
	var incoming_rotation = rotation_diff/INBALANCE_MOVEMENT_DIVIDER
	camera.rotate(incoming_rotation)
	get_node("Background").rotate(incoming_rotation)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#calculate_balance()
	rotate_camera()
	pass

	
	


# func _on_score_timer_timeout():
# 	score += 1

func _on_start_timer_timeout():
	$Flowertimer.start()

func _on_flower_timer_timeout():
	var daisy = daisy_scene.instanciate()
	var daisy_spawn_location = get_node("FlowerSpawn/FlowerSpawnLocation")
	var direction = daisy_spawn_location.rotation + PI/2
	daisy_spawn_location.progress_ratio = randf()
	daisy.position = daisy_spawn_location.position
	daisy.rotation = direction
	add_child(daisy)

func _on_flowertimer_timeout():
	pass # Replace with function body.


extends Node2D

const ZONE_MODIFIERS = [0, 0.2 , 0.4, 0.6, 0.8, 1.0]  # Maximum of 6 entries (3000/ZONE_SPACING = 6)
const ZONE_SPACING = 500	# Spacing of the zones on the map, to calculate the weight modifier
const MAX_INBALANCE = 0.45	# the maximum +/- value for balance until gameover
const INBALANCE_MOVEMENT_DIVIDER = 100	# dictates the tipping speed of the platform 

const DAISY_MAX_TIMER = 60*10 # The Maximum amount of time between daisy spawns
const DAISY_MIN_TIMER = 10*10 # The Maximum amount of time between daisy spawns

@export var daisy_scene: PackedScene

# tracks the balance of the world
var balance = -0.45;
var daisy_countdown = 0
var random = RandomNumberGenerator.new()

var flower_list = []

func calculate_balance():
	var total_weight = 0
	for flower in flower_list:
		var flower_zone = int(flower.global_position.x/ZONE_SPACING)

		if flower_zone < 0:
			total_weight += ZONE_MODIFIERS[flower_zone] * flower.WEIGHT
		else:
			total_weight -= ZONE_MODIFIERS[flower_zone] * flower.WEIGHT
	
	balance = total_weight


func rotate_camera():
	var camera = get_node("Camera2D")
	var cur_rotation = camera.global_rotation
	var rotation_diff = balance - cur_rotation
	var incoming_rotation = rotation_diff/INBALANCE_MOVEMENT_DIVIDER
	camera.rotate(incoming_rotation)
	#get_node("Background").rotate(incoming_rotation)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_timer()
	calculate_balance()
	rotate_camera()
	print(balance)
	pass

func spawn_timer():
	daisy_timer()

func daisy_timer():
	if daisy_countdown <= 0:
		spawn_flower()
		daisy_countdown = random.randi_range(DAISY_MIN_TIMER, DAISY_MAX_TIMER)
	else:
		daisy_countdown -= 1



func spawn_flower():
	var daisy = daisy_scene.instantiate()
	var daisy_spawn_location = get_node("FlowerSpawn/FlowerSpawnLocation")
	var direction = daisy_spawn_location.rotation + PI
	daisy_spawn_location.progress_ratio = randf()
	daisy.position = daisy_spawn_location.position
	daisy.rotation = direction
	flower_list.push_back(daisy)
	print(flower_list)
	add_child(daisy)

func _on_flowertimer_timeout():
	pass # Replace with function body.

extends Node2D

const ZONE_MODIFIERS = [0, 0.2 , 0.4, 0.6, 0.8, 1.0]  # Maximum of 6 entries (3000/ZONE_SPACING = 6)
const ZONE_SPACING = 500	# Spacing of the zones on the map, to calculate the weight modifier
const MAX_INBALANCE = 0.45	# the maximum +/- value for balance until gameover
const INBALANCE_MOVEMENT_DIVIDER = 100	# dictates the tipping speed of the platform 

const DAISY_MAX_TIMER = 60*10 # The Maximum amount of time between daisy spawns
const DAISY_MIN_TIMER = 10*10 # The Maximum amount of time between daisy spawns

const ELEPHANT_MAX_TIMER = 60*30 # The Maximum amount of time between daisy spawns
const ELEPHANT_MIN_TIMER = 10*30 # The Maximum amount of time between daisy spawns
const ELEPHANT_WEIGHT = 0.05


@export var daisy_scene: PackedScene
@export var elephant_scene: PackedScene
@onready var crop_sound = $AudioStreamPlayer2D
@onready var spawn_sound = $spawn_sound_file
@onready var unbalanced_sound = $unbalanced_sound
@onready var balanced_sound = $balanced_sound
@onready var living_edge_sound = $living_on_the_edge_sound
@onready var dont_fall_sound = $dont_fall_sound
# tracks the balance of the world
var balance = -0.45;
var daisy_countdown = 0
var elephant_countdown = 0
var random = RandomNumberGenerator.new()

var finished = false

var flower_list = []
var elephant_list = []
#var played_unbalanced_sound = false
#var played_balanced_sound = false
#var balance_sign = 1
func calculate_balance():
	var total_weight = 0
	for flower in flower_list:
		var flower_zone = int(flower.global_position.x/ZONE_SPACING)
		if flower_zone < 0:
			total_weight += ZONE_MODIFIERS[flower_zone] * flower.WEIGHT
		else:
			total_weight -= ZONE_MODIFIERS[flower_zone] * flower.WEIGHT
	for elephant in elephant_list:
		var elephant_zone = int(elephant.global_position.x/ZONE_SPACING)
		if elephant_zone < 0:
			total_weight += ZONE_MODIFIERS[elephant_zone] * ELEPHANT_WEIGHT
		else:
			total_weight -= ZONE_MODIFIERS[elephant_zone] * ELEPHANT_WEIGHT

	
	balance = total_weight
	#var rndnmbr = random.randf_range(0,50)
	
	

	'if true:
		if balance < 0 and balance_sign != 1 and not played_unbalanced_sound:
			balance_sign = 1
			unbalanced_sound.play()
			played_unbalanced_sound = true
		elif balance > 0 and balance_sign != 2 and not played_unbalanced_sound:
			balance_sign = 2
			unbalanced_sound.play()
			played_unbalanced_sound = true
		else:
			balance_sign = 3
			balanced_sound.play()
			played_unbalanced_sound = false'
			

func _on_Daisy_body_entered(body: PhysicsBody2D) -> void:
	if body.name == "Player":
		# Connect the daisy to the player
		body.crop.connect(self._on_crop_daisy)

func _on_crop_daisy(daisy: Node) -> void:
	# Remove the daisy from the scene
	daisy.queue_free()
	# Play the corresponding audio
	crop_sound.play()
	flower_list.remove_at(flower_list.find(daisy))
	
func rotate_camera():
	var camera = get_node("Camera2D")
	var cur_rotation = camera.global_rotation
	var rotation_diff = balance - cur_rotation
	var incoming_rotation = rotation_diff/INBALANCE_MOVEMENT_DIVIDER
	camera.rotate(incoming_rotation)
	get_node("Background").rotate(incoming_rotation)
	get_node("LowerBackground").rotate(incoming_rotation)
	get_node("Turtle").rotate(incoming_rotation)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not finished:
		get_node("RabbitDead").hide()
		get_node("Turtle").play("default")
		spawn_timer()
		calculate_balance()
		rotate_camera()
		print(get_node("Player").global_position.x)
	if (abs(balance) > MAX_INBALANCE):
		finish_game()
	if (abs(get_node("Player").global_position.x)) > 3100:
		finish_game()
	if (len(elephant_list) >= 4):
		finish_game()
	pass


func finish_game():
	finished = true
	get_node("RabbitDead").show()
	get_node("Player").hide()

func spawn_timer():
	daisy_timer()
	elephant_timer()

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
	spawn_sound.play()
	get_node("Daisies").add_child(daisy)
	
func spawn_elephant():
	var daisy = elephant_scene.instantiate()
	var daisy_spawn_location = get_node("ElephantSpawn/ElephantSpawnLocation")
	var direction = daisy_spawn_location.rotation + PI
	daisy_spawn_location.progress_ratio = randf()
	daisy.position = daisy_spawn_location.position
	daisy.rotation = direction
	elephant_list.push_back(daisy)
	get_node("Elephants").add_child(daisy)
	

func elephant_timer():
	if elephant_countdown <= 0:
		spawn_elephant()
		elephant_countdown = random.randi_range(ELEPHANT_MIN_TIMER, ELEPHANT_MAX_TIMER)
	else:
		elephant_countdown -= 1



func _on_border_right_body_entered(body):
	if body.is_in_group("Ghost"):
		dont_fall_sound.play()
		


func _on_border_left_body_entered(body):
	if body.is_in_group("Ghost"):
		living_edge_sound.play()

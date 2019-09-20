extends Spatial

const rotation_scale = 10
const translation_scale = -5

const SENSIBILIDAD = 0.5

const MAX_SPEED = 30
const MIN_SPEED = 0
const SPEED_STEP = 5

var health = 100
var speed = 0

export(NodePath) var health_indicator_path

onready var animation_player = $ModelRoot/Ciclista/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(health_indicator_path).value = health
	$ModelRoot/Ciclista.visible = true

func _physics_process(delta):
	if globals.is_mobile:
		var tilt = Input.get_accelerometer().x * SENSIBILIDAD
		turn(tilt,delta)
	else:
		if Input.is_action_pressed("ui_left"):
			turn(-1,delta)
		elif Input.is_action_pressed("ui_right"):
			turn(1,delta)
		if Input.is_action_pressed("signal_turn_left"):
			animation_player.play("left_hand")
		elif Input.is_action_pressed("signal_turn_right"):
			animation_player.play("right_hand")
		else:
			rotation_degrees = Vector3.ZERO
	
func turn(amount, delta):
	rotation_degrees = Vector3(0,-amount*rotation_scale,amount*rotation_scale)
	global_translate(Vector3(amount*translation_scale*delta, 0,0))
	if global_transform.origin.x > 9:
		global_transform.origin.x = 9
	if global_transform.origin.x < -8:
		global_transform.origin.x = -8

func modify_speed(step):
	speed += step
	speed = clamp(speed, MIN_SPEED, MAX_SPEED)
	if speed == 0:
		stop()
	else:
		pedal()
	
func pedal():
	if(animation_player.current_animation != "ride1"):
		$ModelRoot/Ciclista/AnimationPlayer.play("ride1")

func stop():
	if(animation_player.current_animation != "stop"):
		$ModelRoot/Ciclista/AnimationPlayer.play("stop")

func crash():
	health -= 10
	$ModelRoot/Ciclista/AnimationPlayer.play("crash")
	speed = 0
	get_node(health_indicator_path).value = health
	if health <= 0:
		print('game over')
		

func monstrify():
	$ModelRoot/Ciclista.visible = false
	$ModelRoot/Monster.visible = true
	$ModelRoot/Monster/AnimationPlayer.play("ride")
	for node in get_tree().get_nodes_in_group("environment"):
		if node.has_method("monstrify"):
			node.monstrify()

func _on_TurnLeft_button_down():
	animation_player.play("left_hand")

func _on_TurnRight_button_down():
	animation_player.play("right_hand")


func _on_InputManager_swiped(gesture):
	if globals.is_mobile:
		var dir = gesture.get_direction()
		if dir == 'up':
			modify_speed(SPEED_STEP)
		if dir == 'down':
			modify_speed(-SPEED_STEP)

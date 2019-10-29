extends Spatial

const rotation_scale = 10
const translation_scale = -5

const SENSIBILIDAD = 0.5

const MAX_SPEED = 30
const MIN_SPEED = 0
const SPEED_STEP = 5

var health = 100
var speed = 0

var acelerar = false
var frenar = false
var anim_finished = false
var monster_level = 0
export(int) var monsterPenalty

export(NodePath) var health_indicator_path
export(NodePath) var monster_indicator_path

onready var animation_player = $ModelRoot/Ciclista/AnimationPlayer

enum RAILS {LEFT_RAIL, CENTRE_RAIL, RIGHT_RAIL}
export(float) var startRight
export(float) var endCentre
export(float) var startCentre
export(float) var endLeft
export(RAILS) var rail

enum HAND_ORIENTATION {LEFT_HAND, RIGHT_HAND, NONE}
var hand_signal 
export(float) var validHandSignal
var handState

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(health_indicator_path).value = health
#	get_node(monster_indicator_path).value = monster_level
	rail = RAILS.RIGHT_RAIL
	$ModelRoot/Ciclista.visible = true

func _physics_process(delta):
	if globals.is_mobile:
		var tilt = Input.get_accelerometer().x * SENSIBILIDAD
		turn(tilt,delta)
	else:
		if Input.is_action_pressed("ui_left"):
			turn(-1,delta)			
			anim_finished = false
		elif Input.is_action_pressed("ui_right"):
			turn(1,delta)			
			anim_finished = false
		else:
			rotation_degrees = Vector3.ZERO
		if Input.is_action_pressed("signal_turn_left"):
			animation_player.play("left_hand")			
			anim_finished = false
		elif Input.is_action_pressed("signal_turn_right"):
			animation_player.play("right_hand")			
			anim_finished = false#		
		if Input.is_action_just_pressed("signal_turn_left"):
			hand_signal = HAND_ORIENTATION.LEFT_HAND
			handState = _hand_signal_enable()
		elif Input.is_action_just_pressed("signal_turn_right"):
			hand_signal = HAND_ORIENTATION.RIGHT_HAND
			handState = _hand_signal_enable()
	if frenar:
		modify_speed(-SPEED_STEP*delta*4)
	if acelerar:		
		modify_speed(SPEED_STEP*delta)
	_check_rail()
	check_speed()
	
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

func check_speed():
	if(speed > 20):
		monster_level += 0.05		
		_set_monster_level()
#	elif(speed < 20): print("normalVelocity")

func pedal():
	if(animation_player.current_animation != "ride1" && anim_finished):
		$ModelRoot/Ciclista/AnimationPlayer.play("ride1")

func stop():
	if(animation_player.current_animation != "stop"):
		$ModelRoot/Ciclista/AnimationPlayer.play("stop")

func crash():
	penalty_player()
	health -= 10
	$ModelRoot/Ciclista/AnimationPlayer.play("crash")
	speed = 0
	get_node(health_indicator_path).value = health
	if health <= 0:
		print('game over')
		

func monstrify():
	$ModelRoot/Ciclista.visible = false
	$ModelRoot/Monster.visible = true
	if(monster_level < 100):
		monster_level = 100
		_set_monster_level()
	$ModelRoot/Monster/AnimationPlayer.play("ride")
	for node in get_tree().get_nodes_in_group("environment"):
		if node.has_method("monstrify"):
			node.monstrify()
			
func normalize():
	$ModelRoot/Monster.visible = false
	$ModelRoot/Ciclista.visible = true
	$ModelRoot/Ciclista/AnimationPlayer.play("ride")
	for node in get_tree().get_nodes_in_group("environment"):
		if node.has_method("normalize"):
			node.normalize()
	
func penalty_player():
	monster_level += monsterPenalty
	_set_monster_level()

func _on_TurnLeft_button_down():
	animation_player.play("left_hand")
	anim_finished = false

func _on_TurnRight_button_down():
	animation_player.play("right_hand")
	anim_finished = false
	

func _on_InputManager_swiped(gesture):
	if globals.is_mobile:
		var dir = gesture.get_direction()
		if dir == 'up':
			modify_speed(SPEED_STEP)
			globals.tutorial = false
		if dir == 'down':
			modify_speed(-SPEED_STEP)

func _on_Pedal_button_down():
	globals.tutorial = false
	acelerar = true
func _on_Pedal_button_up():
	acelerar = false

func _on_Freno_button_down():
	frenar = true
func _on_Freno_button_up():
	frenar = false

func _on_AnimationPlayer_animation_finished(anim_name):
	anim_finished = true
	
func _check_rail():	
	if(global_transform.origin.x < startRight and rail != RAILS.RIGHT_RAIL):
		rail = RAILS.RIGHT_RAIL
		_check_hand_state_Right()
	elif(global_transform.origin.x < startCentre and global_transform.origin.x > endCentre and rail != RAILS.CENTRE_RAIL):		
		_check_hand_state_Centre()
		rail = RAILS.CENTRE_RAIL
	elif(global_transform.origin.x > endLeft and rail != RAILS.LEFT_RAIL):
		rail = RAILS.LEFT_RAIL
		_check_hand_state_Left()

func _hand_signal_enable():
	yield(get_tree().create_timer(validHandSignal), "timeout")	
	hand_signal = HAND_ORIENTATION.NONE
	
func _check_hand_state_Right():
	if(hand_signal == HAND_ORIENTATION.RIGHT_HAND):		
		monster_level -= monsterPenalty/2	
	else:		
		monster_level += monsterPenalty	
	if(handState != null):
		handState.resume()
	_set_monster_level()	

func _check_hand_state_Centre():
	if(rail == RAILS.RIGHT_RAIL and hand_signal == HAND_ORIENTATION.LEFT_HAND):		
		monster_level -= monsterPenalty/2
	elif(rail == RAILS.LEFT_RAIL and hand_signal == HAND_ORIENTATION.RIGHT_HAND):		
		monster_level -= monsterPenalty/2
	else:		
		monster_level += monsterPenalty		
	if(handState != null):
		handState.resume()
	_set_monster_level()	
	
func _check_hand_state_Left():
	if(hand_signal == HAND_ORIENTATION.LEFT_HAND):		
		monster_level -= monsterPenalty/2
	else:		
		monster_level += monsterPenalty
	if(handState != null):
		handState.resume()
	_set_monster_level()	

func _set_monster_level():
	if(monster_level < 0):monster_level = 0		
	if(monster_level > 100):monster_level = 100		
	if(monster_level == 0):normalize()
	elif(monster_level == 100):monstrify()
	get_node(monster_indicator_path).value = monster_level

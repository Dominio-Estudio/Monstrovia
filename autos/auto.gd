extends Spatial

const MIN_SPEED = 10
const MAX_SLOW_SPEED = 20
const MAX_NORMAL_SPEED = 40
const MAX_FAST_SPEED = 60

var player

var world_bounds = Vector2(-20,60)
var speed = 0

enum MODES {FAST, NORMAL, SLOW}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	translate(Vector3(0,0,speed*delta))
	if $RayCastFront.is_colliding():
		var object = $RayCastFront.get_collider()
		if object.is_in_group("vehicles"):
			speed = object.speed
		if object.is_in_group("obstacles") or (object.is_in_group("semaphore") && object.state != 2) or object.is_in_group("ciclorutas"):
				speed = 0

func random_speed(mode):
	match mode:
		MODES.SLOW:
			speed = rand_range(MIN_SPEED,MAX_SLOW_SPEED)
		MODES.NORMAL:
			speed = rand_range(MAX_SLOW_SPEED,MAX_NORMAL_SPEED)
		MODES.FAST:
			speed = rand_range(MAX_NORMAL_SPEED,MAX_FAST_SPEED)
			
func get_random_mode():
#	return randi() % MODES.SLOW + 1 #enums are treated like constants
	return MODES.SLOW #enums are treated like constants


func _on_Auto_body_entered(body):
	if body == player:
		player.crash()
		speed = 0

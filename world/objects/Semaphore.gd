extends Spatial

enum STATES {RED, YELLOW, GREEN}
var RED_TIME = 4
const YELLOW_TIME = 0.5
const GREEN_TIME = 5

var t = 0
var state = STATES.RED
var prev_state = STATES.RED

# Called when the node enters the scene tree for the first time.
func _ready():
	RED_TIME += randi()%3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	match(state):
		STATES.GREEN:
			if t > GREEN_TIME:
				prev_state = state
				state = STATES.YELLOW
				t = 0
				$semaforo/semaforo1/green1001.visible = false
				$semaforo/semaforo2/green2001.visible = false
				$semaforo/semaforo1/yellow1001.visible = true
				$semaforo/semaforo2/yellow2001.visible = true
		STATES.YELLOW:
			if t > YELLOW_TIME:
				state = STATES.YELLOW
				t = 0
				if prev_state == STATES.GREEN:
					state = STATES.RED
					$semaforo/semaforo2/red2001.visible = true
					$semaforo/semaforo1/red1001.visible = true
				else:
					state = STATES.GREEN
					$semaforo/semaforo1/green1001.visible = true
					$semaforo/semaforo2/green2001.visible = true
				$semaforo/semaforo1/yellow1001.visible = false
				$semaforo/semaforo2/yellow2001.visible = false
		STATES.RED:
			if t > RED_TIME:
				prev_state = state
				state = STATES.YELLOW
				t = 0
				$semaforo/semaforo2/red2001.visible = false
				$semaforo/semaforo1/red1001.visible = false				
				$semaforo/semaforo1/yellow1001.visible = true
				$semaforo/semaforo2/yellow2001.visible = true


func _on_Semaphore_body_entered(body):
	if(state == STATES.RED):
		if(body.has_method("monstrify")):
			body.monstrify()

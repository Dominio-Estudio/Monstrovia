extends Camera

export var target: NodePath
var player
var diff: Vector3

func _ready():
	player = get_node(target)
	diff =  transform.origin - (player as Spatial).transform.origin

func _physics_process(delta):
	transform.origin = (player as Spatial).transform.origin + diff

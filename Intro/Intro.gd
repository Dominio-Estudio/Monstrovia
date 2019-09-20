extends VideoPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	change_scene()

func change_scene():
	get_tree().change_scene("res://bicycle_level/Main.tscn")
	

func _on_VideoPlayer_finished():
	change_scene()

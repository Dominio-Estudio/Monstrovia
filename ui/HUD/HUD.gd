extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_pausa():
	$HUD/Pausa/AnimationPlayer.play("desplegar")


func _on_Continuar_pressed():
	$HUD/Pausa/AnimationPlayer.play("replegar")

func toggle_pause():
	get_tree().paused = !get_tree().paused


func _on_Salir_pressed():
	get_tree().change_scene("res://Inicio/Inicio.tscn")


func _on_TurnLeft_button_down():
	pass # Replace with function body.

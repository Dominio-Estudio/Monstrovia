# Creado por Juan Velandia (juankz.github.io) para Dominio Estudio. 2018
extends Control

onready var background_pos = $TextureRect.rect_position

func _ready():
	if globals.tutorial:
		$Personalizacion.visible = false
	$AnimationPlayer.play("Inicio")

func _physics_process(delta):
	if globals.is_mobile:
		var accel = Vector2(Input.get_accelerometer().x, Input.get_accelerometer().y)
		$TextureRect.rect_position = background_pos + accel*2
	else:
		var viewport = get_tree().root
		var hs = viewport.size / 2
		var mouse_diff = viewport.get_mouse_position() - hs
		var offset = Vector2(mouse_diff.x / hs.x, mouse_diff.y / hs.y) * 20 
		$TextureRect.rect_position = background_pos - offset

func ir_a_personalizacion():
	pass
#	get_tree().change_scene("res://SeleccionPersonaje/SeleccionPersonaje.tscn")
#	globals.pantalla_anterior_personalizacion = "res://Inicio.tscn"

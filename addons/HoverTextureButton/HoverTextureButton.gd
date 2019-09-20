# Creado por Juan Velandia (juankz.github.io) para Dominio Estudio. 2018
tool
extends TextureButton

enum ACTION {
	ZOOM, FLOAT
}

export(ACTION) var action = 0
var audio_player

func _enter_tree():
	rect_pivot_offset = rect_size/2
	connect("button_down",self,"_on_Button_button_down")
	connect("button_up",self,"_on_Button_button_up")
	
func _ready():
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = preload("res://addons/HoverTextureButton/click.ogg")
	audio_player.bus = "Sonidos"
	add_child(audio_player)
	
func _on_Button_button_down():
	audio_player.play()
	match action :
		ACTION.ZOOM:
			rect_scale=Vector2(1.2,1.2)
		ACTION.FLOAT:
			rect_position.y -= 10


func _on_Button_button_up():
	match action :
		ACTION.ZOOM:
			rect_scale=Vector2(1,1)
		ACTION.FLOAT:
			rect_position.y += 10

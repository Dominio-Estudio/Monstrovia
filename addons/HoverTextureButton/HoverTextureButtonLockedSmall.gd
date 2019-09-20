# Creado por Juan Velandia (juankz.github.io) para Dominio Estudio. 2018
tool
extends TextureButton

enum ACTION {
	ZOOM, FLOAT
}

export(ACTION) var action = 0
export(bool) var locked

func _enter_tree():
	rect_pivot_offset = rect_size/2
	connect("button_down",self,"_on_Button_button_down")
	connect("button_up",self,"_on_Button_button_up")

func _ready():
	update()
	
func _on_Button_button_down():
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

func _draw():
	if locked :
		texture_normal = preload("res://SeleccionPersonaje/candado_peq.png")
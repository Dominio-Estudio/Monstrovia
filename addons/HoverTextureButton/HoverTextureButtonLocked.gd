# Creado por Juan Velandia (juankz.github.io) para Dominio Estudio. 2018
tool
extends "HoverTextureButton.gd"

export(bool) var locked
	
func _ready():
	update()

func _draw():
	if locked :
		texture_normal = preload("candado.png")
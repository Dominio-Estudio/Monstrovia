# Creado por Juan Velandia (juankz.github.io) para Dominio Estudio. 2018
tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("HoverTextureButton","TextureButton",preload("HoverTextureButton.gd"),preload("icon.png"))

func _exit_tree():
	remove_custom_type("HoverTextureButton")

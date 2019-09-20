extends TextureButton

func _ready():
	get_tree().set_quit_on_go_back(false)
	connect("button_down",self,"_on_Button_button_down")

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		globals.save_game()
		get_tree().quit() # default behavior

func _on_Button_button_down():
	$AudioStreamPlayer.play()
	get_tree().change_scene("res://Intro/Intro.tscn")
#	if globals.tutorial :
#		get_tree().change_scene("res://SeleccionPersonaje/SeleccionPersonaje.tscn")
#	else :
#		get_tree().change_scene("res://SeleccionLugar/SeleccionLugar.tscn")

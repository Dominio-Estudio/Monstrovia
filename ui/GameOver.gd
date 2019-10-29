extends Control

var lose_by_time_frame
var lose_by_healt_frame
var restart_btn
var exit_btn

# Called when the node enters the scene tree for the first time.
func _ready():
	lose_by_healt_frame = $PerdistePorSalud
	lose_by_time_frame = $PerdistePorTiempo
	restart_btn = $ReiniciarBtn
	exit_btn = $SalirBtn

func end_game_by_time():
	lose_by_time_frame.visible = true
	restart_btn.visible = true
	exit_btn.visible = true

func end_game_by_healt():
	lose_by_healt_frame.visible = true
	restart_btn.visible = true
	exit_btn.visible = true

func _on_Jugador_game_over_by_healt():
	end_game_by_healt()


func _on_Main_game_over_by_time():
	end_game_by_time()

func _on_ReiniciarBtn_button_down():
	get_tree().reload_current_scene()


func _on_SalirBtn_button_down():
	get_tree().change_scene("res://Inicio/Inicio.tscn")

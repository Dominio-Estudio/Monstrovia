extends Node2D

var center = Vector2(0,0)
var radius = 50
var angle_from = 0
var angle_to = 0
var border_color = Color(1.0, 1.0, 1.0)
var color = Color("159bff")
var tiempo = 3
signal time_out

func _ready():
	set_defaults()
	set_process(false)

func set_defaults():
	angle_to = 0

func start():
	set_defaults()
	$AudioStreamPlayer.play()
	set_process(true)

func _process(delta):
	angle_to += (360/tiempo)*delta
	if(angle_to>360):
		angle_to = 360
		$AudioStreamPlayer.stop()
		emit_signal("time_out")
		set_process(false)
	update()
	
func _draw():
	draw_circle_arc_poly(center, radius+3, angle_from, angle_to, border_color)
	draw_circle_arc_poly(center, radius, angle_from, angle_to, color)

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	
	for i in range(nb_points+1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	
	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])
	
	for i in range(nb_points+1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)